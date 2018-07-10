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

TEST_FILES_FOLDER = 'unit_test_files'

class TestSportsJSSchema(unittest.TestCase):
    sportsjs_schema = None

    def __init__(self, *args, **kwargs):
        # if we put this in setUp() it would load the schema for each
        # test which is unnecessary.
        import os
        self.current_path = os.path.dirname(os.path.realpath(__file__))
        schema_filename = os.path.join(
            self.current_path,
            '..',
            'specification',
            'sportsjs-core.json'
        )
        with open(schema_filename) as schemafile:
            self.sportsjs_schema = json.load(schemafile)
        return super(TestSportsJSSchema, self).__init__(*args, **kwargs)

    def test_simplest_instance(self):
        """
        jsonschema.validate returns None if valid, raises an exception for
        schema validation errors. So we use assertIsNone.
        """
        self.assertIsNone(jsonschema.validate({}, self.sportsjs_schema))

    """
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
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_simple_soccer_example(self):
        instance = json.loads(
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def load_example_file(self, filename):
        filename = os.path.join(
                        self.current_path,
                        '..',
                        'examples',
                        filename
                    )
        with open(filename, 'r') as jsonfile:
            instance = json.load(jsonfile)
        return instance

    def test_example_file_1(self):
        instance = self.load_example_file('generic-alert.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))
    
    def test_example_file_2(self):
        instance = self.load_example_file('americanFootballEventSummary.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_3(self):
        instance = self.load_example_file('biathlon_mixedrelay_g2.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_4(self):
        instance = self.load_example_file('golf-tour-for-sportsjs.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_5(self):
        instance = self.load_example_file('skiing_vasaloppet_2015_g2.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_6(self):
        # this example is supposed to fail
        with self.assertRaises(jsonschema.exceptions.ValidationError):
            instance = self.load_example_file('soccer-simple-sample-pre-game-not-to-validate.json')
            self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_example_file_7(self):
        instance = self.load_example_file('soccer-simple-sample-pre-game.json')
        self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))
    """

    def get_files_in_folder(self, folder_name):
        folder_name = os.path.join(
                        self.current_path,
                        folder_name
                    )
        return os.listdir(folder_name)

    def load_test_file(self, path, file_name):
        with open(os.path.join(path, file_name), 'r') as jsonfile:
            instance = json.load(jsonfile)
        return instance

    def test_all_passing_example_files(self):
        test_files_path = os.path.join(self.current_path, TEST_FILES_FOLDER, 'should_pass')
        testfiles = self.get_files_in_folder(test_files_path)
        for file in testfiles:
            with self.subTest(file=file):
                instance = self.load_test_file(test_files_path, file)
                self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

    def test_all_failing_example_files(self):
        test_files_path = os.path.join(self.current_path, TEST_FILES_FOLDER, 'should_fail')
        testfiles = self.get_files_in_folder(test_files_path)
        for file in testfiles:
            with self.subTest(file=file):
                with self.assertRaises(jsonschema.exceptions.ValidationError) or self.assertRaises(json.decoder.JSONDecodeError):
                    instance = self.load_test_file(test_files_path, file)
                    self.assertIsNone(jsonschema.validate(instance, self.sportsjs_schema))

if __name__ == '__main__':
    unittest.main()
