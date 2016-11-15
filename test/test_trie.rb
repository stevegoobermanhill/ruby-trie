# some simple tests for RubyTrie
# Stephen.Gooberman-Hill@amey.co.uk
# Nov 2016

require 'minitest/autorun'
require 'trie'
include RubyTrie

class TrieTest < MiniTest::Test
   def test_all
      t=Trie.new
      assert t.root
      assert_equal('', t.root.name)
      assert_nil(t.root.content)
      
      content = t.add('ape',[0])
      assert_kind_of(TrieContent, content)
      assert_equal([0], content.value)
      assert_equal('ape', content.string)
      assert_equal('e', content.symbol)
      
      
      value = t.get('ape')
      assert_equal(content.value, value)
      value << 1
      
      assert_equal([0,1], t.get('ape'))
      
      assert_nil(t.get('ap'))
   end
end
