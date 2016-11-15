# some simple tests for RubyTrie
# Stephen.Gooberman-Hill@amey.co.uk
# (c) Amey Nov 2016
# licenced uner the MIT licence

require 'minitest/autorun'
require 'ruby-trie'
include RubyTrie

class TrieTest < MiniTest::Test
   def test_create
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
   
   def test_children
      t=Trie.new
      t.add('ape',1)
      t.add('apes',2)
      
      c1=t.children('ap')
      assert_equal(['ape','apes'], c1.sort)
      
      c2=t.children_with_values('ap')
      assert_equal(2, c2.size)
      assert_equal(['ape',1], c2.sort.first)
      
      c3=t.children_content('ap')
      assert_equal(2, c3.size)
      assert_equal(['e','ape',1], c3.sort.first)
   end
end
