#!/bin/sh -e

echo "module Sass::Script::Functions
  def hash(url)
    assert_type url, :String
    url = url.to_s.gsub(/^[\"']|[\"']$/, '')
    Sass::Script::String.new({"

for f in $*
do
	echo "      '$f' => 'url(\\'$f?`git hash-object $f`\\')',"
done

echo "    }[url.to_s])
  end
  declare :hash, :args => [:url]
end"
