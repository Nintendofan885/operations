import imp
import unittest


salt_test_case = imp.load_source('salt_test_case', "salt_test_case.py")
jails = imp.load_source('jails', "../_modules/jails.py")


class Testinstance(unittest.TestCase, salt_test_case.SaltTestCase):

    def setUp(self):
        self.initialize_mocks()
        self.instance = jails

        self.mock_pillar('data/jails.yaml')

        self.mock_grains()
        self.grains['id'] = 'host'

    def test_get_default_group(self):
        self.assertEqual('host', jails._get_default_group())

    def test_get_all_jails(self):
        self.assertEqual(['anotherhost', 'host'],
                         sorted(jails._get_all_jails().keys()))

    def test_list(self):
        self.assertEqual(['guest1', 'guest2'],
                         sorted(jails.list()))

    def test_list_for_a_group(self):
        self.assertEqual(['guest3'],
                         sorted(jails.list('anotherhost')))

    def test_flatlist(self):
        self.assertEqual("guest1 guest2", jails.flatlist())

    def test_flatlist_for_a_group(self):
        self.assertEqual("guest3", jails.flatlist('anotherhost'))


if __name__ == '__main__':
    unittest.main()
