# BookHeritage: Rare Book Authentication and Registry Platform

BookHeritage is a decentralized registry built on blockchain technology that enables librarians and collectors to authenticate, catalogue, and preserve rare and historical books.

## Overview

BookHeritage creates a trusted platform for rare book enthusiasts and institutions to document and preserve literary heritage. The platform allows librarians to register books with verifiable details like publication year and preservation state, establishing provenance and authenticity for valuable historical texts.

## Features

- Catalogue rare books with detailed information (title, provenance, genre, preservation state)
- Document publication year for accurate dating and historical context
- Manage availability status for collection items
- Browse books by genre, preservation state, era, or librarian
- Transparent ownership tracking and literary provenance

## Contract Functions

### Public Functions

- `catalogue-book`: Register a rare book in the heritage registry
- `archive-book`: Move a book to archived status
- `get-book`: Retrieve details about a specific rare book
- `get-librarian`: Get the librarian who catalogued a specific book

### Constants

- Minimum publication year validation (1450 - Gutenberg era)
- Validation for literary genres and preservation states
- Error codes for various failure scenarios

## Data Structure

Each book entry contains:
- Librarian information (principal)
- Book title (string)
- Provenance documentation (string)
- Genre classification
- Preservation state
- Availability status
- Publication year

## Getting Started

To interact with the BookHeritage registry:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Catalogue your rare books to establish literary provenance
4. Browse registered books from other librarians and institutions

## Future Development

- Implement digital manuscript storage
- Add scholarly authentication system
- Create literary valuation mechanism
- Develop virtual library showcases and research tools