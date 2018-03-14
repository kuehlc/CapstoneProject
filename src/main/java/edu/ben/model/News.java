package edu.ben.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "news")
@Entity(name = "news")
public class News {

	 @Id
	 @Column(name = "newsID")
	 @GeneratedValue(strategy = GenerationType.AUTO)
	 private int newsID;
	 
	 @Column(name = "title")
	 private String title;
	 
	 @Column(name="filePath")
	 private String filePath;
	 
	 @Column(name="imagepath")
	 private String imagePath;
	 
	 @Column(name="description")
	 private String description;
	 
	 @Column(name="dateCreated")
	 private Timestamp dateCreated;
	 
	 public News(String title, String filePath, String imagePath, String description) {
		 this.title=title;
		 this.filePath = filePath;
		 this.imagePath = imagePath;
		 this.description = description;
	 }

	public int getNewsID() {
		return newsID;
	}

	public void setNewsID(int newsID) {
		this.newsID = newsID;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Timestamp getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}
	 
	 
}
