<div align="left">
 <img src="logo.svg" height="140"/>
</div>

# SQL Acid Test

Despite the existence of the SQL standard, there are still many differences between different SQL engines. Some differences are due to ambiguities or lack of detail in the standard, others are due to historical or political reasons. Those differences make it very hard to write portable SQL queries and generally hinder progress.

The SQL Acid Test defines a common sane understanding of details in SQL SELECT query semantics. This test is inspired by the influential [Acid2 test for Web browsers](https://en.wikipedia.org/wiki/Acid2). The test goes above and beyond the SQL standard and attempts to define sane, desireable behavior. The test should not be confused with the [ACID principles](https://en.wikipedia.org/wiki/ACID) for database transactions.

Tests are written in standard SQL and compiled into a single query. If the tests pass, a smiley face as shown below is displayed. If tests fail, the image is either distorted or not shown at all due to errors in query evaluation. To test your specific SQL system, copy the query in the file `acid.sql` below and run it.

```
 +-----------------+
 |......#####......|
 |....##.....##....|
 |...#.........#...|
 |..#..()...()..#..|
 |..#.....o.....#..|
 |.#.............#.|
 |..#..\...../..#..|
 |..#...-----...#..|
 |...#.........#...|
 |....##.....##....|
 |......#####......|
 +-----------------+
 ```

## Testing

You can use the `test_binary.py` script to easily run all tests on a local binary. Example usage:

```bash
python3 test_binary.py --program sqlite3
python3 test_binary.py --program mysql --extra "-u root"
python3 test_binary.py --program psql --extra "-d postgres"
python3 test_binary.py --program duckdb
```

## Systems known to be compliant

* [Compatibility Matrix](https://docs.google.com/spreadsheets/d/1uDqQeXAWH8N9U6YeY5GpRgDsZugFUrMuz5EpXUutsVs/edit?usp=sharing)

* [PostgreSQL](https://www.postgresql.org)
* [Umbra](https://umbra-db.com)
* [Hyper](https://tableau.github.io/hyper-db/)

## Contribute
We welcome contributions with additional test cases. To add a test case, add a `.sql` file in the `tests` directory and run the `stitch.sh` script.

```bash
./stitch.sh tests/**/*.sql > acid.sql
```

If you want to add compliance tests please cite the relevant sections of the SQL standard.

## Credits
The project was started as part of the [Dagstuhl Seminar 23441 : Ensuring the Reliability and Robustness of Database Management Systems](https://www.dagstuhl.de/en/seminars/seminar-calendar/seminar-details/23441)
