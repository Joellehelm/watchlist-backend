FactoryBot.define do
    factory :show do
        name { 'Doctor Who' }
        genre { 'Adventure, Drama, Sci-Fi' }
        movie_or_show { 'series' }
        year { '2005–2022' }
        imdbID { 'tt0436992' }
        poster { 'https://m.media-amazon.com/images/M/MV5BNjBkMWJkNTYtYjMwYy00ZjZiLWIwYmEtNzMyOTJjODRhNTlhXkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_SX300.jpg' }
        awards { 'Won 4 BAFTA 119 wins & 220 nominations total' }
        actors { 'Jodie Whittaker, Peter Capaldi, Pearl Mackie' }
        total_seasons { '14' }
        imdbRating { '8.6' }
        plot { 'The Doctor, a Time Lord from the race whose home planet is Gallifrey, travels through time and space in their ship the TARDIS (an acronym for Time and Relative Dimension In Space) with numerous companions. From time to time, the Doctor regenerates into a new form.' }
    end
  end