import ballerina/grpc;

// Table to store products
table<Product> key(sku) productsTable = table [];
// Table to store orders
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
    }

    remote function PlaceOrder(PlaceOrderRequest value) returns error? 
    // Place an order for the user (Customer operation)
    Product[]? cart = userCarts.get(value.user_id);
    if (cart is Product[] ){
        Order newOrder = {user_id: value.user_id, items: cart};
        // Placeholder for order ID generation
        string order_id = generateOrderId(); 
        ordersTable.put(newOrder);
        _=userCarts.remove(value.user_id);
        return {order_id: order_id, message: "Order placed successfully"};
    }
    return error("Cart is empty");
}

function generateOrderId() returns string {
     return "ORDER-";
}

    

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

