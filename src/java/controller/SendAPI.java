/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.json.*;

/**
 *
 * @author HelloThang
 */
public class SendAPI {

    private TreeMap<String, String> allAPI = new TreeMap<>();

    public Map<String, String> SaveWorkFlow(String URL, JSONObject js) throws IOException {
        try {
            //Send Request
            URL url = new URL(URL);
            HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
            httpCon.setDoOutput(true);
            httpCon.setDoInput(true);
            httpCon.setUseCaches(false);
            httpCon.setRequestProperty("Content-Type", "application/json");
            httpCon.setRequestProperty("Accept", "application/json");
            httpCon.setRequestMethod("POST");
            httpCon.connect();
            OutputStream os = httpCon.getOutputStream();
            OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");
            osw.write(js.toString());
            osw.flush();
            osw.close();
            //Read data
            StringBuilder sb = new StringBuilder();
            BufferedReader br = new BufferedReader(new InputStreamReader(httpCon.getInputStream(), "utf-8"));
            String line = null;
            while ((line = br.readLine()) != null) {
                sb.append(line + "\n");
            }
            br.close();
            JSONObject json = null;
            JSONObject json1 = new JSONObject(sb.toString());
            for (String key : JSONObject.getNames(json1)) {
//                System.out.println(key + "    " +  json1.get(key).toString());
                allAPI.put(key.trim(), json1.get(key).toString().trim());
            }

            br.close();

        } catch (JSONException ex) {
            Logger.getLogger(SendAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allAPI;
    }

    public TreeMap<String, String> getAllAPI() {
        return allAPI;
    }

    public void setAllAPI(TreeMap<String, String> allAPI) {
        this.allAPI = allAPI;
    }

    public boolean checkToken(String token) {
        try {
            JSONObject js = new JSONObject();
            js.put("token", token);
            js.put("api", "lst_role");
            String code = SaveWorkFlow(constant.Constant.LOCAL_MAIN, js).get("code").toString().trim();
            if (code.equalsIgnoreCase("0")) {
                return true;
            }
        } catch (JSONException ex) {
            Logger.getLogger(SendAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(SendAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
