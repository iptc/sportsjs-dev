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

## Support

The IPTC [Developer Site](http://dev.iptc.org/SportsML) provides technical
information about both SportsJS and SportsML, the XML version of this standard.

Please use the [SportsML Users Forum](https://groups.yahoo.com/neo/groups/sportsml/info)
mailing list to raise questions, or raise an issue on the
[SportsJS GitHub repository](https://github.com/iptc/sportsjs-dev/issues).
