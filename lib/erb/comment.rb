require 'erb'

module Erb
  class Comment < ERB
    VERSION = '0.1.0'

    class CommentScanner < ERB::Compiler::TrimScanner
      def stags
        [*super, '<#--']
      end

      def etags
        [*super, '--#>']
      end
    end

    class CommentCompiler < ERB::Compiler
      def initialize(*)
        super
        @in_comment = false
      end

      def compile_stag(stag, _, scanner)
        case stag
        when '<#--'
          scanner.stag = stag
          @in_comment = true
        else
          super
        end
      end

      def compile_etag(etag, _, scanner)
        case etag
        when '--#>'
          scanner.stag = nil
          @in_comment = false
        else
          super unless @in_comment
        end
      end

      def make_scanner(src)
        CommentScanner.new(src, @trim_mode, @percent)
      end
    end

    def make_compiler(trim_mode)
      CommentCompiler.new(trim_mode)
    end
  end
end
