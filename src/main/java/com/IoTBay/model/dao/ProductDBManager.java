package com.IoTBay.model.dao;

import com.IoTBay.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDBManager extends DBManager<Product> {

    public ProductDBManager(Connection connection) throws SQLException {
        super(connection);
    }

    @Override
    protected Product add(Product product) throws SQLException {
        String sql = "INSERT INTO products (productName, price, productDescription, productImageAddress) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, product.getProductName());
        ps.setFloat(2, product.getPrice());
        ps.setString(3, product.getProductDescription());
        ps.setString(4, product.getProductImageAddress());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            product.setProductID(rs.getInt(1));
        }
        return product;
    }

    @Override
    protected Product get(Product product) throws SQLException {
        String sql = "SELECT * FROM products WHERE productID = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, product.getProductID());

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Product(
                    rs.getInt("productID"),
                    rs.getString("productName"),
                    rs.getFloat("price"),
                    rs.getString("productDescription"),
                    rs.getString("productImageAddress")
            );
        }
        return null;
    }

    @Override
    protected void update(Product oldProduct, Product newProduct) throws SQLException {
        String sql = "UPDATE products SET productName=?, price=?, productDescription=?, productImageAddress=? WHERE productID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, newProduct.getProductName());
        ps.setFloat(2, newProduct.getPrice());
        ps.setString(3, newProduct.getProductDescription());
        ps.setString(4, newProduct.getProductImageAddress());
        ps.setInt(5, oldProduct.getProductID());

        ps.executeUpdate();
    }

    @Override
    protected void delete(Product product) throws SQLException {
        String sql = "DELETE FROM products WHERE productID = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, product.getProductID());

        ps.executeUpdate();
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        ResultSet rs = statement.executeQuery(sql);

        while (rs.next()) {
            products.add(new Product(
                    rs.getInt("productID"),
                    rs.getString("productName"),
                    rs.getFloat("price"),
                    rs.getString("productDescription"),
                    rs.getString("productImageAddress")
            ));
        }

        return products;
    }

    public Product getById(int productId) throws SQLException {
        String sql = "SELECT * FROM products WHERE productID = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Product(
                    rs.getInt("productID"),
                    rs.getString("productName"),
                    rs.getFloat("price"),
                    rs.getString("productDescription"),
                    rs.getString("productImageAddress")
            );
        }

        return null;
    }
}
