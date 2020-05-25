package com.semicolon.h2;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import au.com.bytecode.opencsv.CSVReader;
import dao.StarbucksDAOImpl;
import vo.StarbucksVO;

@Controller
public class FileUploadController {

	@Autowired
	StarbucksDAOImpl dao;
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

// csv file to db
	@RequestMapping("/csv2db2")
	public String csv2db(HttpServletRequest request, String myfile) throws Exception {

		return "starbucks";
	}

	@RequestMapping(value = "/csv2db", method = RequestMethod.POST)
	public String uploadFileHandler(@RequestParam("file") MultipartFile file) {
		String line;
		StarbucksVO vo = new StarbucksVO();
		if (!file.isEmpty()) {
			try {
				InputStream istream = file.getInputStream();
				BufferedReader reader = new BufferedReader(new InputStreamReader(istream, "EUC-KR"));
				reader.readLine();
				while ((line = reader.readLine()) != null) {
					System.out.println(line);
					String str[] = line.split(",");
					vo.setStorename(str[1]);
					vo.setStoreaddr(str[2]);
					vo.setStorelat(Double.valueOf(str[3]));
					vo.setStorelng(Double.valueOf(str[4]));
					dao.insert(vo);						
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}

		return "redirect:starbucks";
	}
}
