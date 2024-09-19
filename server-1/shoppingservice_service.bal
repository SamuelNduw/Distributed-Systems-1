import ballerina/grpc;
import ballerina/io;

// Correctly initialize the table for storing products, using SKU as the key
table<Product> key(sku) productsTable = table [];

table<Order> key(user_id) ordersTable = table [];

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: ONLINESHOPPING_DESC}
service "ShoppingService" on ep {

    remote function AddProduct(AddProductRequest value) returns ProductCodeResponse|error {
        
    }

    remote function UpdateProduct(UpdateProductRequest value) returns ProductCodeResponse|error {
    }

    remote function RemoveProduct(RemoveProductRequest value) returns ProductListResponse|error {
    }

    remote function ListAvailableProducts() returns ProductListResponse|error {
    }

    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
    }

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

    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
    }

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

