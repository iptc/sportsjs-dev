#!/usr/bin/env python

# -*- coding: utf-8 -*-

# Copyright (c) 2018 International Press Telecommunications Council (IPTC)
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

"""
SportsJS unit tests
"""

import unittest
import json
import jsonschema
import os

class TestSportsJSSchema(unittest.TestCase):
    sportsjs_schema = None

    def __init__(self, *args, **kwargs):
        # if we put this in setUp() it would load the schema for each
        # test which is unnecessary.
        import os
        current_path = os.path.dirname(os.path.realpath(__file__))
        schema_filename = os.path.join(current_path, '..', 'specification', 'sportsjs-core.json')
        with open(schema_filename) as schemafile:
            self.sportsjs_schema = json.load(schemafile)
        return super(TestSportsJSSchema, self).__init__(*args, **kwargs)

    def test_simplest_instance(self):
        """
        jsonschema.validate returns None if valid, raises an exception for
        schema validation errors. So we use assertIsNone.
        """
        self.assertIsNone(jsonschema.validate({}, self.sportsjs_schema))

    def test_garbage_fails(self):
        with self.assertRaises(jsonschema.exceptions.ValidationError):
            jsonschema.validate(
                {
                    "foo": "bar"
                },
                self.sportsjs_schema
            )

    def test_generic_alert(self):
        # examples/generic-alert.json
        instance = json.loads(
        """
        {
          "sportsMetadata": {
            "fixtureKey": "spfixt:alert",
            "featureName": {
              "full": "Generic Alert",
              "short": "Alert"
            },
            "documentClass": "spfixt:alert",
            "dateTime": "2016-12-21T00:00:00-04:00",
            "docId": "iptc.alert.a2a204ad-db35-41d4-837d-cded49226292"
          }
        }
        """)
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_simple_soccer_example(self):
        instance = json.loads(
        """
        {
          "sportsMetadata": {
            "docId": "sjs-2016-00-23_Birmingham-Bolton"
          },
          "sportsEvents": [
            {
              "id": "m_1118347",
              "eventMetadata": {
                "startDateTime": "2016-02-23T20:45:00+01:00",
                "endDateTime": "2016-02-23T22:45:00+01:00",
                "name": {
                  "full": "Birmingham - Bolton"
                }
              },
              "teams": [
                {
                  "id": "nifs-t.tim_257_1118347",
                  "teamMetadata": {
                    "key": "Team:nifs-t.tim_257_1118347",
                    "alignment": "home",
                    "name": {
                      "full": "Birmingham"
                    }
                  },
                  "teamStats": {}
                },
                {
                  "id": "nifs-t.tim_253_1118347",
                  "teamMetadata": {
                    "key": "Team:nifs-t.tim_253_1118347",
                    "alignment": "away",
                    "name": {
                      "full": "Bolton"
                    }
                  },
                  "teamStats": {}
                }
              ]
            }
          ]
        }
        """)
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def load_file(self, filename):
        filename = os.path.join(
                        os.path.dirname(os.path.realpath(__file__)),
                        '..',
                        'examples',
                        filename
                    )
        with open(filename, 'r') as jsonfile:
            instance = json.load(jsonfile)
        return instance

    def test_example_file_1(self):
        instance = self.load_file('generic-alert.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))
    
    def test_example_file_2(self):
        instance = self.load_file('americanFootballEventSummary.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_3(self):
        instance = self.load_file('biathlon_mixedrelay_g2.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_4(self):
        instance = self.load_file('golf-tour-for-sportsjs.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_5(self):
        instance = self.load_file('skiing_vasaloppet_2015_g2.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_6(self):
        # this example is supposed to fail
        with self.assertRaises(jsonschema.exceptions.ValidationError):
            instance = self.load_file('soccer-simple-sample-pre-game-not-to-validate.json')
            self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_7(self):
        instance = self.load_file('soccer-simple-sample-pre-game.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

if __name__ == '__main__':
    unittest.main()
