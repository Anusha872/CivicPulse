package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.NewsModel;
import com.Neighborly.utils.DBconfig;

public class NewsDAO {
	
	/**
	 * Inserts a news article.
	 *
	 * Input: userId, title, content, category, imageName
	 * Output: void
	 * Function: Creates a new news record in the database with the provided admin/user author and image.
	 *
	 * @param userId the ID of the author
	 * @param title the news title
	 * @param content the news content
	 * @param category the news category
	 * @param imageName the uploaded image filename
	 * @throws Exception if a database error occurs
	 */
	public void insertNews(int userId, String title, String content, String category, String imageName) throws Exception {
	    
		Connection con = DBconfig.getConnection();
		
	    String sql = "INSERT INTO news (user_id, news_title, news_content, news_category, news_image) VALUES (?, ?, ?, ?, ?)";
	    
	    PreparedStatement pst = con.prepareStatement(sql);
	    
	    pst.setInt(1, userId);
	    pst.setString(2, title);
	    pst.setString(3, content);
	    pst.setString(4, category);
	    pst.setString(5, imageName);
	    pst.executeUpdate();
	    pst.close();
	    con.close();
	}	
	
	/**
	 * Retrieves all news articles.
	 *
	 * Input: none
	 * Output: List<NewsModel>
	 * Function: Loads every news item from the database ordered by the newest post first.
	 *
	 * @return a list of all news articles
	 * @throws Exception if a database error occurs
	 */
	public List<NewsModel> getAllNews() throws Exception {

	    List<NewsModel> newsList = new ArrayList<>();

	    Connection con = DBconfig.getConnection();
	    
	    String sql = "SELECT news_id, user_id, news_title, news_content, news_category, news_image, news_created_at FROM news "
	    		+ "ORDER BY news_created_at DESC";

	    PreparedStatement pst = con.prepareStatement(sql);

	    ResultSet rs = pst.executeQuery();

	    while (rs.next()) {

	        NewsModel n = new NewsModel();

	        n.setNewsId(rs.getInt("news_id"));
	        n.setAdminId(rs.getInt("user_id"));
	        n.setNewsTitle(rs.getString("news_title"));
	        n.setNewsDescription(rs.getString("news_content"));
	        n.setNewsCategory(rs.getString("news_category"));
	        n.setPostedAt(rs.getString("news_created_at"));
	        n.setNewsImage(rs.getString("news_image"));
	        newsList.add(n);
	    }

	    rs.close();
	    pst.close();
	    con.close();
	    return newsList;
	}

	/**
	 * Updates a news article without changing its image.
	 *
	 * Input: newsId, title, content, category
	 * Output: void
	 * Function: Updates the text fields of an existing news record while keeping the current image unchanged.
	 *
	 * @param newsId the ID of the news item
	 * @param title the updated news title
	 * @param content the updated news content
	 * @param category the updated category
	 * @throws Exception if a database error occurs
	 */
    public void updateNews(int newsId, String title, String content, String category) throws Exception {
    	
        Connection con = DBconfig.getConnection();
        
        String sql = "UPDATE news SET news_title = ?, news_content = ?, news_category = ? WHERE news_id = ?";
        
        PreparedStatement pst = con.prepareStatement(sql);
        
        pst.setString(1, title);
        pst.setString(2, content);
        pst.setString(3, category);
        pst.setInt(4, newsId);
        pst.executeUpdate();
        pst.close();
        con.close();
    }

    /**
     * Updates a news article and replaces its image.
     *
     * Input: newsId, title, content, category, imageName
     * Output: void
     * Function: Updates the news record including the new image filename.
     *
     * @param newsId the ID of the news item
     * @param title the updated news title
     * @param content the updated news content
     * @param category the updated category
     * @param imageName the new image filename
     * @throws Exception if a database error occurs
     */
    public void updateNewsWithImage(int newsId, String title, String content, String category, String imageName) throws Exception {
    	
        Connection con = DBconfig.getConnection();
        
        String sql = "UPDATE news SET news_title = ?, news_content = ?, news_category = ?, news_image = ? WHERE news_id = ?";
        
        PreparedStatement pst = con.prepareStatement(sql);
        
        pst.setString(1, title);
        pst.setString(2, content);
        pst.setString(3, category);
        pst.setString(4, imageName);
        pst.setInt(5, newsId);
        pst.executeUpdate();
        pst.close();
        con.close();
    }

    /**
     * Deletes a news article from the database.
     *
     * Input: newsId
     * Output: boolean
     * Function: Permanently removes the selected news record and returns whether the delete succeeded.
     *
     * @param newsId the ID of the news item
     * @return true if the record was deleted, otherwise false
     * @throws Exception if a database error occurs
     */
	public boolean deleteNews(int newsId) throws Exception {
		Connection con = DBconfig.getConnection();

		String sql = "DELETE FROM news WHERE news_id = ?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, newsId);

		int rowsAffected = pst.executeUpdate();

		pst.close();
		con.close();

		return rowsAffected > 0;

	}

}