# rtrie
# a pure Ruby trie implementation
# because fast-trie is broken and segfaults

# Stephen Gooberman-Hill@amey.co.uk
# Nov 2016

gem 'tree'
require 'tree'

module RubyTrie
   # the content of a TrieNode
   class TrieContent
      attr_reader :symbol, :string
      attr_accessor :value
      
      # Initialize with the full string (not just the symbol)
      # and an optional value
      # You should not need to use this class unless you start
      # walking the Trie 
      def initialize(str, value=nil)
         @string = str
         @symbol = str[-1]
         @value = value
      end
   end

   # A TrieNode is a node in the Trie
   # derives from the Tree class
   # You should only need this class if you use Tree methods
   # to walk the tree and such-like
   class TrieNode < Tree::TreeNode
      # Specialized version of TreeNode
      
      # adds adds a node at a particular point
      # if the node already exists, then it will
      # overwrite the value
      def add_node(string, value)
         current_node = self.root
         current_string = ''
         chars = string.split('')
         
         chars.each do |c|
            current_string << c
            child = current_node[c]
            unless child 
               child = TrieNode.new(c)
               current_node.add(child)
            end
            current_node = child
         end
         
         current_node.content = TrieContent.new(string, value)   
      end
      
      # gets the value at a node
      # returns nil if the node does not exist
      def get_node(string)
         current_node = self.root
         current_string = ''
         chars = string.split('')
         
         chars.each do |c|
            current_string << c
            current_node = current_node[c]
            break unless current_node
         end
         
         current_node&.content&.value
      end
   end

   # Trie implements a Trie structure via an
   # underlying implementation using Tree
   # Trie has a single attribute (root) which is the root
   # TrieNode
   class Trie
      #The Trie just holds the root node
   
      attr_reader :root
      
      # create an empty Trie
      def initialize
         @root = TrieNode.new('')
      end
      
      # add a string with optional value to teh Trie
      # Note - will overwrite the value if the node
      # already exists
      def add(string, value=nil)
         @root.add_node(string, value)
      end
      
      # get the value at a node
      #returns nil if the node does not exist
      def get(string)
         @root.get_node(string)
      end
   end
end     



