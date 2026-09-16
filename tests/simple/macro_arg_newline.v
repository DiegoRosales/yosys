// Whitespace surrounding a macro argument is not part of the argument, so it must
// not defeat `` token pasting. macro_arg_surrounding_spaces.v covers spaces and tabs
// on the callsite's own line; this covers the case where that whitespace spans a
// newline, i.e. the argument sits on a continuation line.
//
// The comment variants of this bug (an argument preceded by a // or /* */ comment)
// are covered by tests/verilog/macro_arg_comment.ys instead: iverilog rejects them,
// so they cannot be cross-checked by the tests/simple flow.
module macro_arg_newline_top(
	IDENT_V_,
	IDENT_W_,
	IDENT_X_,
	i,
	o
);
	`define MACRO(dummy, x) IDENT_``x``_
	output wire IDENT_V_;
	// argument on a continuation line, indented with spaces
	output wire `MACRO(_,
        W);
	// argument on a continuation line, indented with tabs
	output wire `MACRO(_,
			X);

	// Whitespace *inside* an argument is part of it and must be preserved: only
	// the leading and trailing runs are stripped.
	`define ADD(a, b) ((a) + (b))
	input wire [3:0] i;
	output wire [3:0] o;
	assign o = `ADD( i + 4'd1 ,
	                 i );
endmodule
