#!/bin/sh -e

cat <<RUBY
module Sass::Script::Functions
  def hash(url)
    assert_type url, :String
    url = url.to_s.gsub(/^["']|["']$/, '')
    Sass::Script::String.new({
RUBY

for f in $*
do
	printf "      '$f' => 'url(\\'$f?%s\\')',\n" "`git hash-object $f`"
done

cat <<RUBY
    }[url.to_s])
  end
  declare :hash, :args => [:url]
end
RUBY
