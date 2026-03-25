class ApiConstants {
  static const String baseUrl = "https://codingarabic.online/api";

  // Authentication
  static const String register = "/register"; //
  static const String login = "/login"; //
  static const String logout = "/logout"; //
  static const String forgetPassword = "/forget-password"; //
  static const String resetPassword = "/reset-password"; //
  static const String verifyEmail = "/verify-email"; //
  static const String resendVerifyCode = "/resend-verify-code"; //

  static const String checkForgetPassword = "/check-forget-password"; //

  // Sliders
  static const String sliders = "/sliders";

  // Products & Categories
  static const String categories = "/categories";
  static const String products = "/products";
  static const String productDetails = "/product-details"; // يحتاج ID
  static const String newArrival = "/products-new-arrival";
  static const String search = "/products-search";

  // Books
  static const books = "/books";
  static const bestSeller = "/products-bestseller";

  // Profile
  static const String profile = "/profile";
  static const String updateProfile = "/update-profile";
  static const String updatePassword = "/update-password";
  static const String deleteProfile = "/delete-profile";

  // Wishlist
  static const wishlist = "/wishlist";
  static const addToWishlist = "/add-to-wishlist";
  static const removeFromWishlist = "/remove-from-wishlist";

  // Cart
  static const String cart = "/cart";
  static const String addToCart = "/add-to-cart";
  static const String updateCart = "/update-cart";
  static const String removeFromCart = "/remove-from-cart";

  // Orders
  static const String checkout = "/checkout";
  static const String placeOrder = "/place-order";
  static const String orderHistory = "/order-history";
  static const String showSingleOrder = "/show-single-order";

  // Address
  static const String governorates = "/governorates";
}
