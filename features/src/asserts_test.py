from asserts import assert_sets_equality

def test_asserts_sets_equality():
    assert_sets_equality("something", set(), set())
    assert_sets_equality("something", {1}, {1})
    assert_sets_equality("something", {1, 2}, {1, 2})
    assert_sets_equality("something", {1, 2}, {2, 1})

