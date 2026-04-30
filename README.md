# PTest

A lightweight macOS desktop application designed for algorithm practice and testing. PTest allows users to manage problem descriptions (with Markdown rendering) and validate test cases by comparing expected outputs with actual program results.

> **NOTICE**
> This project is in development, and will be released in August.

## Features

- **Question Management**: Store titles and descriptions.
- **Test Data Validation**: Input custom test data and manually verify outputs.

## Tech Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Database**: Core Data (fault-tolerance handling is in development)

## Project Structure

- **`ContentView.swift`**: Main navigation and list view.
- **`QuestionView.swift`**: Renders Markdown content for problem descriptions.
- **`EditQuestionView.swift`**: Interface for adding/editing questions.
- **`TestsView.swift`**: Logic for parsing test data and comparing results.
- **`Persistence.swift`**: Core Data stack with error handling.

## License

Distributed under the MIT License. See `LICENSE` for more information.
