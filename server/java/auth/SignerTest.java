package com.ksyun.ksvs.auth.demo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.junit.Test;

import com.ksyun.ksvs.auth.demo.Signer.AWSParamBuilder;
import com.ksyun.ksvs.auth.demo.Signer.AWSParams;

public class SignerTest {

	@Test
	public void generateAuthHeader() {
		
		String myPackageName = "com.ksyun.java.demo";
		
		//Please replace the values
		String kscAccessKey = "AKLTrH0TBf1hQT23_BL3n1jvJ"; //金山云控制台->身份与管理->身份与访问控制->身份与访问控制->主账户信息->账户秘钥
		String kscSecretKey = "OAw42ekJXRANm+/GwA7eDaCZ5afwdNlceDk123452JYc3NCuFlsPSdMO7V2HgY1w4w==";
		
		String kscAPIHost = "ksvs.cn-beijing-6.api.ksyun.com";
		String kscAPIRegion = "cn-beijing-6";
		String kscAPIService = "ksvs";
		String kscAPIAction = "KSDKAuth";
		String kscAPIVersion = "2017-04-01";

		Map<String, String> paramKV = new HashMap<String, String>();
		paramKV.put("Action", kscAPIAction);
		paramKV.put("Version", kscAPIVersion);
		paramKV.put("Pkg", myPackageName);
		String query = encodeParams(paramKV);

		AWSParamBuilder builder = new AWSParamBuilder();
	    builder.setHost(kscAPIHost);
	    builder.setRegion(kscAPIRegion);
	    builder.setService(kscAPIService);
	    builder.setQuery(query);
	    String AMZDate = AWSSigner.getAMZDate();
	    String NTD = AWSSigner.getNoTimeDate();
	    builder.setAMZDate(AMZDate);
	    builder.setNTD(NTD);
	    AWSParams awsParams = builder.build();
	    
	    Map<String, String> signResult = AWSSigner.signRequest(awsParams, kscSecretKey, kscAccessKey);
	    
	    Map<String, Map<String, Object>> responseObject = new HashMap<String, Map<String, Object>>();
	    Map<String, Object> responseData = new HashMap<String, Object>();
	    responseData.put("RetMsg", "success");
	    responseData.put("RetCode", 0);
	    signResult.remove("host");
	    responseData.putAll(signResult);
	    responseObject.put("Data", responseData);
	    
	    //System.out.println(JSONObject.toJSONString(responseObject));
	}

	private String encodeParams(Map<String, String> params) {
		List<String> keyValuePairString = new ArrayList<String>();

		List<String> paramKeys = new ArrayList<String>(params.keySet());
		Collections.sort(paramKeys, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});

		for (String paramKey : paramKeys) {
			if (!StringUtils.isBlank(params.get(paramKey))) {
				keyValuePairString.add(paramKey + "=" + params.get(paramKey));
			} else if (StringUtils.EMPTY.equals(params.get(paramKey))) {
				keyValuePairString.add(paramKey);
			} else {
				// Ignore
			}
		}

		return StringUtils.join(keyValuePairString.toArray(), "&");
	}
}
