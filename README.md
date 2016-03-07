***Art Review***

The situation in this application is that artists are invited to review the works of their fellow artists.  One of the goals of the application is to ensure peer review of as many drawings as possible (for simplicity, "drawings" are the only works of art).

The universe consists of artists, drawings, and reviews.

An artist is the typical user of the application.
Artists interact with the system in these ways:

1.  They create drawings.
2.  They ask to review a drawing created by a different artist, which they specify by rating the drawing on a simple, integer scale (say, from 1 to 5).

The application was created by people who are interested in understanding how/why artists rate each other's work.  In pursuit of this interest, they wish to get all drawings reviewed, more or less by the same number of reviews.

***Database***

There is a table of **artists**.

There is a table of **drawings** each of which belongs to (has a foreign key to) one artist.

There is a table of **reviews** each of which belongs to a drawing, a reviewing artist, and a numerical review-value.

Among the constraints in the system are the fact that an artist can review a given drawing at most once.  Also, an artist cannot review his/her own drawing.

***The SQL***

__for_review_by(reviewing_artist)__.  For a given artist, return an list drawings suitable for review by that artist, ordered from the least to the most-reviewed drawings.

Example:

Let a1 through a4 be artists.

Let a1 have created one drawing.

Let a2 have created several drawings, d1 through d4.

Assume that artists have already completed the following reviews:

* a1 has reviewed a2's d1.

* a3 and a4 have reviewed a2's d3.

* a3 has reviewed a2's d4.

The query, __for_review_by(p1)__, should return the drawings d2, d4, and d3, in that order.  The drawing, d2, is first, because it hasn't yet been reviewed by anyone.  The drawing d4 comes next, having been reviewed only by one artist (p3).  Finally, d3 has been reviewed by two artists (d3 and d4).

The drawing by a1 is never included for review by a1, nor is a2's d1 which has already been reviewed by a1.

***Getting Started***

This is a small Rails 4.2.5.2, Ruby 2.3.0 application using a SQLLite DB.  Git-clone it, bundle, create the database and perform the migration:

```ruby
bundle
bundle exec rake db:create
bundle exec rake db:migrate
```

You should now be able to run the one and only test that illustrates the SQL query:

```ruby
bundle exec rake
```