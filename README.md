### Why?

Oh 'cmon, live a little. Haven't you ever thought it would be great
if you could get a `Rakefile` to control the install process of your
`extconf.rb` based native RubyGem?

### What's the problem Sparky?

Previous assumptions often turn out to be wrong. Such is the case with this code from
RubyGems that is called when RG installs your native gem. It's wrong to assume that
`make` should be called after successfully running your `extconf.rb` file.

In the majority of use cases `extconf.rb` will generate a `Makefile`, but there are
a number of interesting use cases in which your `extconf.rb` might want to bypass
(at runtime) creating a `Makefile`. RubyGems currently prevents you, the gem author,
from being able to make this decision.

<pre><code>
class Gem::Ext::ExtConfBuilder &lt; Gem::Ext::Builder

  def self.build(extension, directory, dest_path, results)
    cmd = "#{Gem.ruby} #{File.basename extension}"
    cmd &lt;&lt; " #{Gem::Command.build_args.join ' '}" unless Gem::Command.build_args.empty?

    run cmd, results

    make dest_path, results

    results
  end

end
</code></pre>

That's a trivial fix to RG, right? Just check `run`'s return value before calling `make`.
Done, submit the pull request and move on. Well, you've got two more hurdles in front
to clear. The first is the current implementation of `Gem::Ext::Builder#run`

<pre><code>
class Gem::Ext::Builder

  def self.run(command, results)
    results &lt;&lt; command
    results &lt;&lt; `#{command} #{redirector}`

    unless $?.success? then
      raise Gem::InstallError, "#{class_name} failed:\n\n#{results.join "\n"}"
    end
  end

end
</code></pre>

The second hurdle for your SuperPatch is to figure out how `extconf.rb` can signal
`Gem::Ext::ExtConfBuilder.build` that a `Makefile` wasn't created and `make`
shouldn't be run. And do it in a way that doesn't break existing `extconf.rb`'s.
