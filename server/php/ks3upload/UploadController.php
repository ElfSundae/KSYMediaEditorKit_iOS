<?php
namespace App\Http\Controllers;
use App\Http\Requests;
use Illuminate\Http\Request;
use App\Thirdparty\Ks3\Ks3Client;


class UploadController extends Controller
{


	private function getAuthInfoByClientParam($httpVerb, $contMd5, $contType, $resource, $headers, $date = null) {
        $ak = config('ks3.ak');
        $sk = config('ks3.sk');

        if(empty($date)){
		    $gmtDate = gmdate('D, d M Y H:i:s \G\M\T');
        }else{
            $gmtDate = $date;
        }
        Log::debug($gmtDate);
		$arrToSign = array(
			$httpVerb,
			$contMd5,
			$contType,
			$gmtDate,
		);
		if (!empty($headers)) {
			array_push($arrToSign, $headers);
		}
		array_push($arrToSign, $resource);
		$strToSign = join("\n", $arrToSign);

        Log::debug($strToSign);
		$signature = base64_encode(hash_hmac('sha1', $strToSign, $sk, true));
		$strAuth = 'KSS ' . $ak . ':' . $signature;
		$arrRes = array(
			'Date'			=> $gmtDate,
			'Authorization' => $strAuth,
		);
		return $arrRes;
	}

    public function GetKs3Signature(Request $request) {

        $verb = $request->input('verb');
        $md5 = $request->input('md5');
        $type = $request->input('type');
        $res = $request->input('res');
        $headers = $request->input('headers');
        $date = $request->input('date');

        $ret = $this->getAuthInfoByClientParam($verb, $md5, $type, $res, $headers, $date);
        return response()->json($ret);
    }


    public function doSign($object, $bucket, $expire, $ak, $sk) {
        $resource = sprintf("/%s/%s", $bucket, $object);
        $resource = str_replace("%2F", "/", urlencode($resource));
        $str2sign = sprintf("GET\n\n\n%d\n%s", $expire, $resource);

        $h = hash_hmac("sha1", $str2sign, $sk, true);
        $Signature = trim(base64_encode($h));

        $url = sprintf("%s%s?KSSAccessKeyId=%s&Expires=%d&Signature=%s", "ks3-cn-beijing.ksyun.com", $resource, $ak, $expire, $Signature);
        return $url;
    }


	public function GetKs3SignedUrl(Request $request){
    	$objKey = $request->input("objkey");
        $url = $this->doSign($objKey, config("ks3.bucket"), time() + 60 * 60 * 24, config('ks3.ak'),config('ks3.sk'));

         $arrResult  = array(
             'errno' => 0,
             'errmsg' => 'success',
             'presigned_url' => "https://{$url}",
         );

        return response()->json($arrResult);
	}
}
