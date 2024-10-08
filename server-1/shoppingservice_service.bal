import ballerina/grpc;
import ballerina/io;

// Table to store products
table<Product> key(sku) productsTable = table [];
// Table to store orders
table<Order> key(user_id) ordersTable = table [];

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: ONLINESHOPPING_DESC}
service "ShoppingService" on ep {

        
    // THEODORE
    remote function AddProduct(AddProductRequest value) returns ProductCodeResponse|error {

    Product newProduct = {
        sku: value.product.sku,
        name: value.product.name,
        description: value.product.description,
        price: value.product.price,
        status: value.product.status
    };

    var existingProduct = productsTable[value.product.sku];
    if existingProduct is Product {
        return error("Product with SKU " + value.product.sku + " already exists.");
    }

    productsTable.add(newProduct);
    io:println("Product added: ", newProduct);

    ProductCodeResponse response = {
        product_code: value.product.sku
    };
    return response;
    }
    
    // NATANGWE
    remote function UpdateProduct(UpdateProductRequest value) returns ProductCodeResponse|error {
        string sku = value.sku;
        Product updatedProduct = value.product;

        foreach var product in productsTable {
            if product.sku == sku {
                Product temp = productsTable.remove(product.sku);
                productsTable.add(updatedProduct);
                io:println("Updated product: ", updatedProduct.name);
                return {product_code: updatedProduct.sku};
            }
        }
        return error("Product not found for SKU: " + sku);
    }

    // MARTIN
    remote function RemoveProduct(RemoveProductRequest value) returns ProductListResponse|error {
            // Extract SKU from request
        string skuToRemove = value.sku;

        // Check if the product exists in the table
        Product? productToRemove = productsTable[skuToRemove];
        if (productToRemove is Product) {
            // Remove the product from the table
            Product delete = productsTable.remove(skuToRemove);
            
            // Fetch the updated list of products
            Product[] updatedProducts = from Product product in productsTable select product;

            // Create response with updated list of products
            ProductListResponse response = {
                products: updatedProducts
            };
            
            return response;
        } else {
            // If product does not exist, return an error
            return error("Product with SKU '" + skuToRemove + "' not found.");
        }

    }

    // CAROLINE
    remote function ListAvailableProducts() returns ProductListResponse|error { 
    //Creating an Array
    Product[] availableProducts = from Product product in productsTable 
                                  where product.status == "available"
                                  select product;

    // Create response with available products list
    ProductListResponse response = {
        products: availableProducts
    };

    // Return the ProductList
    return response;

    }

    // BEAVEN
    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
         // Extract the sku from the request
    string sku = value.sku;
    
    // Check if the product exists in the productsTable using the 'sku'
        foreach var product in productsTable {
            if product.sku == sku {
                // Return the product 
                return {product: product};
            }
        }
        // Return an error if the product with that specific 'sku' does not exist
        return error("Product not found with SKU: " + sku);
    }

    // SAMUEL
    remote function AddToCart(AddToCartRequest value) returns error? {
        string userId = value.user_id;
        string sku = value.sku;

        foreach var product in productsTable {
            if product.sku == sku && product.status == "available" {
                Product cartProduct = product;
                var cartEntry = ordersTable[userId];
                if cartEntry is Order {
                    cartEntry.products.push(cartProduct);
                } else {
                    Order newOrder = {user_id: userId, products: [cartProduct]};
                    ordersTable.add(newOrder);
                }
                io:println("Added product to cart for user: ", userId);
                return;
            }
        }
        return error("Product not available or does not exist with SKU: " + sku);
    }

    // ANETTE
    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
        string userId = value.user_id;
        var cartEntry = ordersTable[userId];

        if cartEntry is Order {
            io:println("Order placed for user: ", userId, " with products: ", cartEntry.products);
            Order od = ordersTable.remove(cartEntry.user_id);
            return;
        }
        return error("No cart found for user: " + userId);
    }

    // SAMUEL
    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        User[] users = [];
        error? e = clientStream.forEach(function(CreateUsersRequest userReq) {
            users.push(userReq.user);
            io:println("User created: ", userReq.user.user_id);
        });

        if e is error {
            return e;
        }
        return {status: "Users created successfully"};
    }
}