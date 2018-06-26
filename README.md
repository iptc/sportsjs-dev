# IPTC SportsJS 1.0 Draft

SportsJS is an open and highly flexible standard for the interchange of sports data
in JSON, created by the International Press Telecommunications Council (IPTC).

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

For example, to clone this repository, install the [`ajv-cli`|] validator, and
use it to validate the provided examples:

    $ git clone https://github.com/iptc/sportsjs-dev.git
    $ cd sportsjs-dev
    $ npm install -g ajv-cli
    $ ajv validate  -s specification/sportsjs-core.json -r "specification/sportsjs-*.json" -d "examples/*.json"
    americanFootballEventSummary.json valid
    biathlon_mixedrelay_g2.json valid
    generic-alert.json valid
    golf-tour-for-sportsjs.json valid
    skiing_vasaloppet_2015_g2.json valid
    soccer-simple-sample-pre-game-not-to-validate.json invalid
    [ { keyword: 'additionalProperties',
        dataPath: '',
        schemaPath: '#/additionalProperties',
        params: { additionalProperty: 'sportsetadata' },
        message: 'should NOT have additional properties' } ]
    soccer-simple-sample-pre-game.json valid

Note that the `soccer-simple-sample-pre-game-not-to-validate.json` example has
been deliberately modified in order to test that invalid instance files fail to
validate.

Or if you would prefer to validate using Python's `jsonschema`:
    $ git clone https://github.com/iptc/sportsjs-dev.git
    $ cd sportsjs-dev
    $ mkvirtualenv --python=python3 sportsjs
    (sportsjs) $ pip install jsonschema
    (sportsjs) $ jsonschema -i examples/generic-alert.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/americanFootballEventSummary.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/biathlon_mixedrelay_g2.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/golf-tour-for-sportsjs.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/skiing_vasaloppet_2015_g2.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/soccer-simple-sample-pre-game.json specification/sportsjs-core.json
    (sportsjs) $ jsonschema -i examples/soccer-simple-sample-pre-game-not-to-validate.json specification/sportsjs-core.json
    {'sportsetadata': {'docId': 'sjs-2016-00-23_Birmingham-Bolton'}, 'sportsEvents': [{'id': 'm_1118347', 'eventMetadata': {'startDateTime': '2016-02-23T20:45:00+01:00', 'endDateTime': '2016-02-23T22:45:00+01:00', 'name': {'full': 'Birmingham - Bolton'}}, 'teams': [{'id': 'nifs-t.tim_257_1118347', 'teamMetadata': {'key': 'Team:nifs-t.tim_257_1118347', 'alignment': 'home', 'name': {'full': 'Birmingham'}}, 'teamStats': {}}, {'id': 'nifs-t.tim_253_1118347', 'teamMetadata': {'key': 'Team:nifs-t.tim_253_1118347', 'alignment': 'away', 'name': {'full': 'Bolton'}}, 'teamStats': {}}]}]}: Additional properties are not allowed ('sportsetadata' was unexpected)

Again, this error is expected as the example deliberately fails to validate
against the schema.

## Tests

We have created some unit tests for the schema itself to ensure that our schema
stays valid according to our examples. It contains some simple schemas embedded
in the test script, and it also loads all of the example files in the `examples`
folder.

It is written in Python, and can be run with:

    $ python tests/specification_tests.py

## Support

The [IPTC Developer Site](http://dev.iptc.org/SportsML) provides technical
information about both SportsJS and SportsML, the XML version of this standard.

Please use the [SportsML Users Forum](https://groups.yahoo.com/neo/groups/sportsml/info)
mailing list to raise questions, or raise an issue on the
[SportsJS GitHub repository](https://github.com/iptc/sportsjs-dev/issues).
