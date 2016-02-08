// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"mojom/mojom_parser/lexer"
)

// AttachCommentsToMojomFile attaches the comments in |comments| to the elements
// in |mojomFile|. Which element a comment is attached to is a
// function of the respective locations in the mojom file of the comment and the
// element.
// Note: This function expects that the mojom file is already parsed.
// The following rules are implemented:
//
// Comments on a standalone line are attached to the next element. (Which will be on a line below)
// Comments preceeding the first element on a line are attached to that first element.
// Comments are attached to the last element that preceeds them on the same line.
// Comments at the end of a line are attached to the first element on the line.
// Comments at the end of the file are attached to the file itself.
//
// Example:
//
// // Attached to Foo
// /* Attached to Foo */ interface Foo {
//   Bar(int32 arg1 /* Attached to arg1 */, int32 arg2); // Attached to Bar.
// };
//
// // Attached to the mojom file.
func AttachCommentsToMojomFile(mojomFile *MojomFile, comments []lexer.Token) {
	if len(comments) == 0 {
		return
	}
	elementStream := NewMojomFileVisitor(mojomFile)
	commentStream := NewCommentStream(comments)
	var firstLineElement MojomElement

	for elementStream.Peek() != nil {
		var above []lexer.Token
		var left []lexer.Token
		var right []lexer.Token

		curElement := elementStream.Next()
		nextElement := elementStream.Peek()
		if firstLineElement == nil {
			firstLineElement = curElement
			// Get the comments on preceeding lines.
			above = commentStream.GetBeforeLine(firstLineElement.MainToken())
			// Get the comments at the beginning of the line.
			left = commentStream.GetBeforeToken(firstLineElement.MainToken())
		}

		if nextElement != nil && nextElement.MainToken().LineNo == firstLineElement.MainToken().LineNo {
			// Get the comments before the next token, only if the next token is on the same line.
			right = commentStream.GetBeforeToken(nextElement.MainToken())
		}

		if len(above) > 0 || len(left) > 0 || len(right) > 0 {
			attachedComments := curElement.NewAttachedComments()
			attachedComments.Above = above
			attachedComments.Left = left
			attachedComments.Right = right
		}

		// If we are currently looking at the last element on the line, the
		// remaining comments on this line are assigned to the first element on the
		// line.
		//
		// To understand why, consider the following likely scenario:
		// MethodFoo(int param1, int param2) => (int out) // This method adds things.
		// It won't always be correct, but it should be fine most of the time.
		if nextElement == nil || nextElement.MainToken().LineNo > firstLineElement.MainToken().LineNo {
			right = commentStream.GetRemainingOnLine(curElement.MainToken())
			if len(right) > 0 {
				attachedComments := firstLineElement.AttachedComments()
				if attachedComments == nil {
					attachedComments = firstLineElement.NewAttachedComments()
				}
				attachedComments.Right = right
			}
			firstLineElement = nil
		}
	}
	mojomFile.FinalComments = commentStream.GetRemaining()
}

// CommentStream represents a stream of comments in the order in which they
// occur in the mojom file which contains them.
type CommentStream struct {
	commentTokens []lexer.Token
	curIdx        int
}

// NewCommentStream returns a new CommentStream based on an array of comments.
func NewCommentStream(commentTokens []lexer.Token) (commentStream *CommentStream) {
	commentStream = new(CommentStream)
	commentStream.commentTokens = commentTokens
	return
}

// matchFunction embodies a criteria for tokens. If the token meet the criteria
// matchFunction returns true. Otherwise matchFunction returns false.
type matchFunction func(commentToken *lexer.Token) bool

// getFollowingMatching returns the longest slice of comment tokens starting at
// the current index such that all the comments in the slice match the provided
// criteria.
// A token matches the provided criteria if the matchFunction returns true when
// passed the token under consideration.
func (cs *CommentStream) getFollowingMatching(matchFunction matchFunction) (tokens []lexer.Token) {
	curIdx := cs.curIdx
	for curIdx < len(cs.commentTokens) && matchFunction(&cs.commentTokens[curIdx]) {
		curIdx += 1
	}
	tokens = cs.commentTokens[cs.curIdx:curIdx]
	cs.curIdx = curIdx
	return
}

// GetBeforeLine gets remaining comments on lines above that of the reference token.
func (cs *CommentStream) GetBeforeLine(refToken *lexer.Token) (tokens []lexer.Token) {
	matchFunction := func(commentToken *lexer.Token) bool {
		return commentToken.LineNo < refToken.LineNo
	}

	return cs.getFollowingMatching(matchFunction)
}

// GetBeforeToken gets remaining comments before the reference token.
func (cs *CommentStream) GetBeforeToken(refToken *lexer.Token) (tokens []lexer.Token) {
	matchFunction := func(commentToken *lexer.Token) bool {
		return commentToken.SourcePos < refToken.SourcePos
	}

	return cs.getFollowingMatching(matchFunction)
}

// GetRemainingOnLine returns the remaining tokens on the same line as the reference tokens.
func (cs *CommentStream) GetRemainingOnLine(refToken *lexer.Token) []lexer.Token {
	matchFunction := func(commentToken *lexer.Token) bool {
		return commentToken.LineNo == refToken.LineNo
	}

	return cs.getFollowingMatching(matchFunction)
}

// GetRemaining returns the comment tokens that are left in the stream.
func (cs *CommentStream) GetRemaining() (tokens []lexer.Token) {
	tokens = cs.commentTokens[cs.curIdx:len(cs.commentTokens)]
	cs.curIdx = len(cs.commentTokens)
	return
}

// AttachedComments describes comments associated with an element of a mojom
// file and their location relative to that element.
type AttachedComments struct {
	// Above lists comments above the element.
	Above []lexer.Token

	// Left lists comments to the left of the element.
	Left []lexer.Token

	// Right lists comments to the right of the element.
	Right []lexer.Token
}

// CommentsAttachment can be embedded in structs to add a pointer to
// AttachedComments and implement the comment-related parts of the
// MojomElement interface.
type CommentsAttachment struct {
	attachedComments *AttachedComments
}

// See MojomElement.
func (a *CommentsAttachment) AttachedComments() *AttachedComments {
	return a.attachedComments
}

// See MojomElement.
func (a *CommentsAttachment) NewAttachedComments() *AttachedComments {
	a.attachedComments = new(AttachedComments)
	return a.attachedComments
}
