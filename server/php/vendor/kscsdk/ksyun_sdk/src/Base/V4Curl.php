<?php
/**
 * creator: maigohuang
 */ 
namespace Ksyun\Base;

use GuzzleHttp\Client;
use GuzzleHttp\HandlerStack;
use GuzzleHttp\Handler\CurlHandler;
use GuzzleHttp\Handler\MockHandler;
use GuzzleHttp\Psr7\Request;
use GuzzleHttp\Psr7\Response;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Middleware;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;

abstract class V4Curl extends BaseCurl 
{
    protected function __construct()
    {
		$mock = new MockHandler([
			new Response(200, ['X-Foo' => 'Bar']),
			new Response(202, ['Content-Length' => 0]),
			new RequestException("Error Communicating with Server", new Request('GET', 'test'))
		]);
        $this->stack = HandlerStack::create($mock);
        $this->stack->push($this->replaceUri());
        $this->stack->push($this->v4Sign());

        /* $this->stack->push($mock); */


		$history = Middleware::history($this->container);
        $this->stack->push($history);

        $config = $this->getConfig();
        $this->client = new Client([
            'handler' => $this->stack,
            'base_uri' => $config['host'],
        ]);

    }

    protected function v4Sign()
    {
        return function (callable $handler) {
            return function (RequestInterface $request, array $options) use ($handler) {
                $v4 = new SignatureV4();
                $credentials = $options['v4_credentials'];
                if (!isset($credentials['ak']) || !isset($credentials['sk'])) {
                    $json = json_decode(file_get_contents(getenv('HOME') . '/.ksyun/config'), true);
                    if (is_array($json) && isset($json['ak']) && isset($json['sk'])) {
                        $credentials = array_merge($credentials, $json);
                    }
                }
                $request = $v4->signRequest($request, $credentials);
                return $handler($request, $options);
            };
        };
    }

    /* protected function getSign() */
    /* { */
    /*     $headers = isset($options['headers']) ? $options['headers'] : []; */
    /*     $body = isset($options['body']) ? $options['body'] : null; */
    /*     $version = isset($options['version']) ? $options['version'] : '1.1'; */
    /*     // Merge the URI into the base URI. */
    /*     $uri = $this->buildUri($uri, $options); */
    /*     if (is_array($body)) { */
    /*         $this->invalidBody(); */
    /*     } */
    /*     $request = new Psr7\Request($method, $uri, $headers, $body, $version); */

    /*     return function (callable $handler) { */
    /*         return function (RequestInterface $request, array $options) use ($handler) { */
    /*             $v4 = new SignatureV4(); */
    /*             $credentials = $options['v4_credentials']; */
    /*             if (!isset($credentials['ak']) || !isset($credentials['sk'])) { */
    /*                 $json = json_decode(file_get_contents(getenv('HOME') . '/.ksyun/config'), true); */
    /*                 if (is_array($json) && isset($json['ak']) && isset($json['sk'])) { */
    /*                     $credentials = array_merge($credentials, $json); */
    /*                 } */
    /*             } */
    /*             $request = $v4->signRequest($request, $credentials); */
    /*             return $handler($request, $options); */
    /*         }; */
    /*     }; */
    /* } */
}

