"""Unit tests for functions defined in asserts.py source file."""

from asserts import assert_sets_equality


def test_asserts_sets_equality():
    """Test the behaviour or assert_sets_equality function."""
    assert_sets_equality("something", set(), set())
    assert_sets_equality("something", {1}, {1})
    assert_sets_equality("something", {1, 2}, {1, 2})
    assert_sets_equality("something", {1, 2}, {2, 1})

