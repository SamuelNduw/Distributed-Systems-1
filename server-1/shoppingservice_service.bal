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
        string sku = value.sku;

        if productsTable.hasKey(sku) {
            Product existingProduct = productsTable[sku];
            existingProduct.name = value.name;
            existingProduct.description = value.description;
            existingProduct.price = value.price;
            productsTable[sku] = existingProduct;

            io:println("Product updated: ", existingProduct.name);
            return {productCode: sku};
        } else {
            return error("Product not found with SKU: " + sku);
        }
    }
}

type Product record {
    string sku;
    string name;
    string description;
    decimal price;
};

type UpdateProductRequest record {
    string sku;
    string name;
    string description;
    decimal price;
};

type ProductCodeResponse record {
    string productCode;
};


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
