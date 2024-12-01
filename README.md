# Movie App

A SwiftUI-based app demonstrating the use of SwiftUI, Combine, Clean Architecture, Modularization, Caching, and Unit Testing. The app features two main screens:

1. **Movie List Screen**: Displays a list of movies with search and filter functionalities.
2. **Movie Details Screen**: Shows detailed information about a selected movie.

## Features

- **Movie List Screen**: 
  - Displays a list of movies fetched from an API.
  - Supports search and filtering based on movie genres.
  
- **Movie Details Screen**: 
  - Shows detailed information about a selected movie, including its title, release date, genres, and more.

## Technical Stack

- **SwiftUI**: UI framework for building the user interface.
- **Combine**: For managing data streams and handling async operations.
- **Modularization**: The app is structured into multiple modules for better maintainability and scalability.
- **Clean Architecture**: The app follows a clean architecture approach to separate concerns and ensure the code is testable, maintainable, and scalable.
- **Unit Testing**: Comprehensive unit tests have been written for key features to ensure the reliability and stability of the app.
- **Caching**: Data fetched from the network is cached to reduce network calls and improve performance.

## Setup and Installation

To get started with the project, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/Adel-Aref/SwiftUIAndCombineDemo.git
    ```

2. Open the project in Xcode:

    ```bash
    open MovieApp.xcodeproj
    ```

3. Run the project in Xcode by selecting the desired scheme and clicking the **Run** button.

## Architecture

The app follows the **Clean Architecture** principles:

- **Entities**: The core business logic objects.
- **Use Cases**: The application's operations, such as fetching movies or displaying movie details.
- **Repositories**: Interface between the use cases and the data source (API or database).
- **Views (UI)**: SwiftUI views for displaying content to the user.
  
The project also implements **Modularization** to ensure that different features are independent, scalable, and easily testable.

## Caching

The app uses a caching mechanism to store movie data locally, reducing the need for repeated network calls. The cache is automatically updated when the app fetches new data.

## Unit Testing

Unit tests are written using XCTest to ensure the correctness of critical logic in the app. Tests cover:

- API responses and parsing.
- ViewModel data transformations.
- Business logic in use cases.

## Schemes

The app uses different schemes for various environments and configurations:

- **Development**: For running the app in the development environment.
- **Production**: For the production environment.
- **Test**: For running tests and checking app behavior during development.

## Future Improvements

- Implement pagination in the movie list to handle large datasets.
- Add more detailed error handling for API requests.
- Enhance caching mechanism for offline support.

## Contribution

Feel free to fork this project, make improvements, and submit pull requests. Contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
