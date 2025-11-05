# Book It Up

### About

The purpose of this app is for users to be able to organize books into lists from a catalog of books curated by all users. Users can search for books to add them onto the books catalog. Once added, users can add them onto their personal lists and create new lists. Users can also add reviews onto books.


### Installation for Local Set Up

Install Ruby, Rails, and PostgreSQL 
Ensure a postgresql server is running on port 5432
Once all programs are installed, run the following command:

```
git clone https://github.com/julielee1001/book-it-up.git
```
Once downloaded, open to its directory:

```
cd ../book-it-up
```
Then run:
```
bundle install
```
Then create a google books api key and place it in an .env file as GOOGLE_BOOKS_API_KEY.
Once that's set up run:
```
rails server
```
