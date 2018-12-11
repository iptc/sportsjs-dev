# IPTC SportsJS 1.0 Draft

SportsJS is an open and highly flexible standard for the interchange of sports data
in JSON, created by the [International Press Telecommunications Council (IPTC)](https://iptc.org/).

It is designed to be easy to understand and implement, and to cover a wide
variety of sports competitions. It is based on a direct translation to JSON Schema
from the SportsML 3.0 XML Schema and the aim is to keep it semantically consistent
with SportsML.

We currently provide a draft4 JSON Schema, but we intend to upgrade this to draft7
and higher as new drafts of the JSON Schema standard are released.

## Features

* Modular Multi-sport schema
  * American Football
  * Baseball
  * Basketball
  * Curling
  * Golf
  * Ice Hockey
  * Motor Racing
  * Rugby 
  * Soccer 
  * Tennis
  * Generic Sport statistics
* Flexible tournament structure
* Flexible event structure
* Flexible team structure
* Flexible player structure
* Generic statistic structures
* Semantic structures and vocabularies

### Usage

The `specification` folder contains the work-in-progress JSON Schema files for
SportsJS.


### Example files

We have created example files showing how SportsJS can be used to express data
for various sport events including American football, biathlon, golf, skiing and
soccer.

The examples are all in the `examples` folder and can be validated using any
JSON Schema validator.

For example, follow these steps to clone this repository, install the
[`ajv-cli`](https://www.npmjs.com/package/ajv-cli) validator, and use it to
validate the provided examples:

    $ git clone https://github.com/iptc/sportsjs-dev.git
    $ cd sportsjs-dev
    $ npm install -g ajv-cli
    $ ajv validate  -s specification/sportsjs-core.json -r "specification/sportsjs-*.json" -d "examples/*.json"
    examples/amfoot-match-classic-generic.json valid
    examples/amfoot-match-classic-specific.json valid
    examples/amfoot-match-g2-generic.json valid
    examples/amfoot-match-g2-specific.json valid
    [ ... ]
    examples/soccer-standings-classic-specific.json valid
    examples/soccer-standings-g2-specific.json valid
    examples/tennis_davis_cup_tournament.json valid
    examples/tournament-cl-classic.json valid
    examples/tournament-cl-g2.json valid

Or if you would prefer to validate using Python's `jsonschema`, follow these
steps (unfortunately the command-line version of jsonschema doesn't allow file
globbing so we have to do some magic with `find -exec`):

    $ git clone https://github.com/iptc/sportsjs-dev.git
    $ cd sportsjs-dev
    $ mkvirtualenv --python=python3 sportsjs
    (sportsjs) $ pip install jsonschema
    (sportsjs) $ find examples/*.json -exec jsonschema -i {} specification/sportsjs-core.json \;
    (sportsjs) $
    (no response means there were no validation errors)

## Tests

We have created some unit tests for the schema itself to ensure that our schema
stays valid according to our examples. It loads a series of test instance documents
stored in `tests/unit_test_files/should_pass` and `should_fail`, and also tests
against all examples in the `examples` folder.

It is written in Python, and can be run with:

    $ python tests/specification_tests.py

## Support

The [IPTC Developer Site](http://dev.iptc.org/SportsML) provides technical
information about both SportsJS and SportsML, the XML version of this standard.

Please use the [SportsML Users Forum](https://groups.io/g/iptc-sportsml)
mailing list to raise questions, or raise an issue on the
[SportsJS GitHub repository](https://github.com/iptc/sportsjs-dev/issues).
