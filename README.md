# Clara Mobile Challenge
Mobile application that interacts with the Discogs API

### Technical requirements
#### API Integration
- [ ] Use the Authorization header for API authentication.
- [ ] Use pagination on all the requests that support it with 30 elements per page.
#### Design Patterns, Architecture, and Best Practices
- [ ] The use of design patterns and architectural patterns is required.
- [ ] Ensure a clear separation of concerns between the presentation and data layers.
- [ ] Follow platform and language-specific best practices to create a high-quality, maintainable codebase.
#### Error Handling
- [ ] Handle scenarios such as no results, failed API requests, or missing data gracefully with appropriate user messages.
#### Unit tests
- [ ] Include unit tests for the project’s critical parts.
#### Bonus points (optional)
- [ ] Include a static code analyzer in the project to maintain code quality.

### Functional requirements
#### Main Screen & Search Functionality
- [ ] The main screen starts with an empty state, and search results are presented in a list
- [ ] Display an empty state view prompting the user to search for an artist.
- [ ] Provide a search bar where the user can input an artist’s name to fetch results from the Discogs API
- [ ] Present search results in a list, with each cell containing the artist’s thumbnail and name
- [ ] Tapping on a cell will open a detail view
#### Artist Detail View
- [ ] Display the most relevant information about the artist, including an option to navigate to a list of the artist's albums
- [ ] If the artist is a band, include a section within the details view that displays a list of the band members
#### Artist’s Albums View
- [ ] Each cell in this list should include the most relevant information about the album
- [ ] The album list must be sorted by release date, from newest to oldest
- [ ] Implement filtering options in the discography, allowing users to filter albums by year, genre, or label

### Platform requirements
- **Language**: Swift
- **Minimum OS Version**: iOS 15 or later
- **UI Framework**: SwiftUI
- **Dependency Management**: Swift Package Manager (SPM)

### Bonus points
- [ ] Implement local data caching for images
- [ ] Create a view of the album details, including relevant information and the tracklist
- [ ] Present the artist details and releases from the band members list

