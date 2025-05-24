//package com.IoTBay.model.dao;
//
//import com.IoTBay.model.Product;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class ProductDBManager extends DBManager<Product> {
//
//    public ProductDBManager(Connection connection) throws SQLException {
//        super(connection);
//    }
//
//    @Override
//    protected Product add(Product product) throws SQLException {
//        String sql = "INSERT INTO products (productName, price, productDescription, productImageAddress) VALUES (?, ?, ?, ?)";
//        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
//        ps.setString(1, product.getProductName());
//        ps.setFloat(2, product.getPrice());
//        ps.setString(3, product.getProductDescription());
//        ps.setString(4, product.getProductImageAddress());
//        ps.executeUpdate();
//
//        ResultSet rs = ps.getGeneratedKeys();
//        if (rs.next()) {
//            product.setProductID(rs.getInt(1));
//        }
//
//        return product;
//    }
//
//    public Product addProduct(Product product) throws SQLException {
//        return add(product);
//    }
//
//    public void deleteProduct(Product product) throws SQLException {
//        delete(product);
//    }
//
//    public void updateProduct(Product oldProduct, Product newProduct) throws SQLException {
//        update(oldProduct, newProduct);
//    }
//
//    @Override
//    protected Product get(Product product) throws SQLException {
//        String sql = "SELECT * FROM products WHERE productID = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, product.getProductID());
//
//        ResultSet rs = ps.executeQuery();
//        if (rs.next()) {
//            return new Product(
//                    rs.getInt("productID"),
//                    rs.getString("productName"),
//                    rs.getFloat("price"),
//                    rs.getString("productDescription"),
//                    rs.getString("productImageAddress")
//            );
//        }
//        return null;
//    }
//
//    @Override
//    public void update(Product oldProduct, Product newProduct) throws SQLException {
//        String sql = "UPDATE products SET productName=?, price=?, productDescription=?, productImageAddress=? WHERE productID=?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setString(1, newProduct.getProductName());
//        ps.setFloat(2, newProduct.getPrice());
//        ps.setString(3, newProduct.getProductDescription());
//        ps.setString(4, newProduct.getProductImageAddress());
//        ps.setInt(5, oldProduct.getProductID());
//        ps.executeUpdate();
//    }
//
//    @Override
//    protected void delete(Product product) throws SQLException {
//        String sql = "DELETE FROM products WHERE productID = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, product.getProductID());
//
//        ps.executeUpdate();
//    }
//
//    public List<Product> getAllProducts() throws SQLException {
//        List<Product> products = new ArrayList<>();
//        String sql = "SELECT * FROM products";
//        ResultSet rs = statement.executeQuery(sql);
//
//        while (rs.next()) {
//            products.add(new Product(
//                    rs.getInt("productID"),
//                    rs.getString("productName"),
//                    rs.getFloat("price"),
//                    rs.getString("productDescription"),
//                    rs.getString("productImageAddress")
//            ));
//        }
//
//        return products;
//    }
//
//    public Product getById(int productId) throws SQLException {
//        String sql = "SELECT * FROM products WHERE productID = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setInt(1, productId);
//        ResultSet rs = ps.executeQuery();
//
//        if (rs.next()) {
//            return new Product(
//                    rs.getInt("productID"),
//                    rs.getString("productName"),
//                    rs.getFloat("price"),
//                    rs.getString("productDescription"),
//                    rs.getString("productImageAddress")
//            );
//        }
//
//        return null;
//    }
//}

package com.IoTBay.model.dao;

import com.IoTBay.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDBManager extends DBManager<Product> {

    public ProductDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    @Override
    protected Product add(Product product) throws SQLException {
        String sql =
                "INSERT INTO products (productName, price, productDescription, productImageAddress, stock) " +
                        "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getProductName());
            ps.setFloat(2, product.getPrice());
            ps.setString(3, product.getProductDescription());
            ps.setString(4, product.getProductImageAddress());
            ps.setInt(5, product.getStock());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    product.setProductID(rs.getInt(1));
                }
            }
        }
        return product;
    }

    public Product addProduct(Product p) throws SQLException {
        return add(p);
    }

    public void deleteProduct(Product p) throws SQLException {
        delete(p);
    }

    public void updateProduct(Product oldP, Product newP) throws SQLException {
        update(oldP, newP);
    }

    @Override
    protected Product get(Product template) throws SQLException {
        String sql = "SELECT * FROM products WHERE productID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, template.getProductID());
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Product p = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("price"),
                        rs.getString("productDescription"),
                        rs.getString("productImageAddress"),
                        rs.getInt("stock")
                );
                return p;
            }
        }
    }

    @Override
    public void update(Product oldP, Product newP) throws SQLException {
        String sql =
                "UPDATE products SET productName=?, price=?, productDescription=?, productImageAddress=?, stock=? " +
                        "WHERE productID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newP.getProductName());
            ps.setFloat(2, newP.getPrice());
            ps.setString(3, newP.getProductDescription());
            ps.setString(4, newP.getProductImageAddress());
            ps.setInt(5, newP.getStock());
            ps.setInt(6, oldP.getProductID());
            ps.executeUpdate();
        }
    }

    @Override
    protected void delete(Product p) throws SQLException {
        String sql = "DELETE FROM products WHERE productID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, p.getProductID());
            ps.executeUpdate();
        }
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Statement st = connection.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("price"),
                        rs.getString("productDescription"),
                        rs.getString("productImageAddress"),
                        rs.getInt("stock")
                );
                list.add(p);
            }
        }
        return list;
    }

    public Product getById(int productId) throws SQLException {
        String sql = "SELECT * FROM products WHERE productID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Product p = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("price"),
                        rs.getString("productDescription"),
                        rs.getString("productImageAddress"),
                        rs.getInt("stock")
                );
                return p;
            }
        }
    }
}




