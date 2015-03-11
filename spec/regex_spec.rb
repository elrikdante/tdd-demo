require File.expand_path './lib/myregex'

describe MyRegex do
  subject      { reggy.match? input }
  let (:body)  { 'a' }
  let (:reggy) { MyRegex::build body }


  context "Parsing a" do

    context "Literal match: " do

      context '/abc/' do

        let (:body) { 'abc' }

        context 'applied to "abc"' do
          let (:input) { "abc" }

          it "matches" do
            should eq(true)
          end
        end

        context 'applied to "abcd"' do
          let (:input) { 'abcd' }

          it "matches" do
            should eq(true)
          end
        end

        context 'applied to "b"' do
          let (:input) { 'x' }

          it "doesn't match" do
            should eq(false)
          end
        end
      end
    end

    context 'single wild card match' do
      let (:body) { "ab." }

      context '/ab./' do
        context 'applied to "abc"' do
          let (:input) { 'abc' }

          it 'matches' do
            should eq(true)
          end
        end

        context 'applied to "ab1"' do
          let (:input) { 'ab1' }

          it 'matches' do
            should eq(true)
          end
        end

        context 'applied to "bac"' do
          let (:input) {'bac' }
          it 'doesnt match' do
            should eq(false)
          end
        end

      end
    end

    context 'a character class' do
      let (:body) { "ab[123]" }

      context 'ab[123] applied to ' do
        context 'ab1' do
          let (:input) { 'ab1' }
          it 'matches' do
            should eq(true)
          end
        end

        context 'ab2' do
          let (:input) { 'ab2' }
          it 'matches' do
            should eq(true)
          end
        end

        context 'abz' do
          let (:input) { 'abz' }
          it 'doesnt match' do
            should eq(false)
          end
        end
      end
    end
  end
end
