import ballerina/grpc;

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

    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
    }

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

