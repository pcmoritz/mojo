// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:sky' as sky;
import 'package:sky/framework/layout2.dart';

const double kTwoPi = 2 * math.PI;

double deg(double radians) => radians * 180.0 / math.PI;

class SectorConstraints {
  const SectorConstraints({
    this.minDeltaRadius: 0.0,
    this.maxDeltaRadius: double.INFINITY,
    this.minDeltaTheta: 0.0,
    this.maxDeltaTheta: kTwoPi
  });

  const SectorConstraints.tight({ double deltaRadius: 0.0, double deltaTheta: 0.0 })
    : minDeltaRadius = deltaRadius,
      maxDeltaRadius = deltaRadius,
      minDeltaTheta = deltaTheta,
      maxDeltaTheta = deltaTheta;

  final double minDeltaRadius;
  final double maxDeltaRadius;
  final double minDeltaTheta;
  final double maxDeltaTheta;

  double constrainDeltaRadius(double deltaRadius) {
    return clamp(min: minDeltaRadius, max: maxDeltaRadius, value: deltaRadius);
  }

  double constrainDeltaTheta(double deltaTheta) {
    return clamp(min: minDeltaTheta, max: maxDeltaTheta, value: deltaTheta);
  }
}

class SectorDimensions {
  const SectorDimensions({ this.deltaRadius: 0.0, this.deltaTheta: 0.0 });

  factory SectorDimensions.withConstraints(
    SectorConstraints constraints,
    { double deltaRadius: 0.0, double deltaTheta: 0.0 }
  ) {
    return new SectorDimensions(
      deltaRadius: constraints.constrainDeltaRadius(deltaRadius),
      deltaTheta: constraints.constrainDeltaTheta(deltaTheta)
    );
  }

  final double deltaRadius;
  final double deltaTheta;
}

class SectorParentData extends ParentData {
  double radius = 0.0;
  double theta = 0.0;
}

abstract class RenderSector extends RenderNode {

  void setParentData(RenderNode child) {
    if (child.parentData is! SectorParentData)
      child.parentData = new SectorParentData();
  }

  SectorDimensions getIntrinsicDimensions(SectorConstraints constraints, double radius) {
    return new SectorDimensions.withConstraints(constraints);
  }

  void layout(SectorConstraints constraints, { RenderNode relayoutSubtreeRoot }) {
    deltaRadius = constraints.constrainDeltaRadius(0.0);
    deltaTheta = constraints.constrainDeltaTheta(0.0);
    layoutDone();
  }

  double deltaRadius;
  double deltaTheta;
}

class RenderDecoratedSector extends RenderSector {
  BoxDecoration _decoration;

  RenderDecoratedSector(BoxDecoration decoration) : _decoration = decoration;

  void setBoxDecoration(BoxDecoration decoration) {
    if (_decoration == decoration)
      return;
    _decoration = decoration;
    markNeedsPaint();
  }

  // origin must be set to the center of the circle
  void paint(RenderNodeDisplayList canvas) {
    assert(deltaRadius != null);
    assert(deltaTheta != null);
    assert(parentData is SectorParentData);

    if (_decoration == null)
      return;

    if (_decoration.backgroundColor != null) {
      sky.Paint paint = new sky.Paint()..color = _decoration.backgroundColor;
      sky.Path path = new sky.Path();
      double outerRadius = (parentData.radius + deltaRadius);
      sky.Rect outerBounds = new sky.Rect()..setLTRB(-outerRadius, -outerRadius, outerRadius, outerRadius);
      path.arcTo(outerBounds, deg(parentData.theta), deg(deltaTheta), true);
      double innerRadius = parentData.radius;
      sky.Rect innerBounds = new sky.Rect()..setLTRB(-innerRadius, -innerRadius, innerRadius, innerRadius);
      path.arcTo(innerBounds, deg(parentData.theta + deltaTheta), deg(-deltaTheta), false);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
}

class SectorChildListParentData extends SectorParentData with ContainerParentDataMixin<RenderSector> { }

class RenderSectorRing extends RenderDecoratedSector with ContainerRenderNodeMixin<RenderSector, SectorChildListParentData> {
  // lays out RenderSector children in a ring

  RenderSectorRing({
    BoxDecoration decoration,
    double deltaRadius: double.INFINITY,
    double padding: 0.0
  }) : super(decoration), _padding = padding, _desiredDeltaRadius = deltaRadius;

  double _desiredDeltaRadius;
  double get desiredDeltaRadius => _desiredDeltaRadius;
  void set desiredDeltaRadius(double value) {
    assert(value != null);
    if (_desiredDeltaRadius != value) {
      _desiredDeltaRadius = value;
      markNeedsLayout();
    }
  }

  double _padding;
  double get padding => _padding;
  void set padding(double value) {
    // TODO(ianh): avoid code duplication
    assert(value != null);
    if (_padding != value) {
      _padding = value;
      markNeedsLayout();
    }
  }

  void setParentData(RenderNode child) {
    // TODO(ianh): avoid code duplication
    if (child.parentData is! SectorChildListParentData)
      child.parentData = new SectorChildListParentData();
  }

  SectorDimensions getIntrinsicDimensions(SectorConstraints constraints, double radius) {
    double outerDeltaRadius = constraints.constrainDeltaRadius(desiredDeltaRadius);
    double innerDeltaRadius = outerDeltaRadius - padding * 2.0;
    double childRadius = radius + padding;
    double paddingTheta = math.atan(padding / (radius + outerDeltaRadius));
    double innerTheta = paddingTheta; // increments with each child
    double remainingDeltaTheta = constraints.maxDeltaTheta - (innerTheta + paddingTheta);
    RenderSector child = firstChild;
    while (child != null) {
      SectorConstraints innerConstraints = new SectorConstraints(
        maxDeltaRadius: innerDeltaRadius,
        maxDeltaTheta: remainingDeltaTheta
      );
      SectorDimensions childDimensions = child.getIntrinsicDimensions(innerConstraints, childRadius);
      innerTheta += childDimensions.deltaTheta;
      remainingDeltaTheta -= childDimensions.deltaTheta;
      assert(child.parentData is SectorChildListParentData);
      child = child.parentData.nextSibling;
      if (child != null) {
        innerTheta += paddingTheta;
        remainingDeltaTheta -= paddingTheta;
      }
    }
    return new SectorDimensions.withConstraints(constraints,
                                                deltaRadius: outerDeltaRadius,
                                                deltaTheta: innerTheta);
  }

  SectorConstraints _constraints;
  void layout(SectorConstraints constraints, { RenderNode relayoutSubtreeRoot }) {
    if (relayoutSubtreeRoot != null)
      saveRelayoutSubtreeRoot(relayoutSubtreeRoot);
    relayoutSubtreeRoot = relayoutSubtreeRoot == null ? this : relayoutSubtreeRoot;
    deltaRadius = constraints.constrainDeltaRadius(desiredDeltaRadius);
    assert(deltaRadius < double.INFINITY);
    _constraints = constraints;
    internalLayout(relayoutSubtreeRoot);
  }

  void relayout() {
    // TODO(ianh): avoid code duplication
    assert(parentData is SectorParentData);
    internalLayout(this);
  }

  void internalLayout(RenderNode relayoutSubtreeRoot) {
    assert(this.parentData is SectorParentData);
    double innerDeltaRadius = deltaRadius - padding * 2.0;
    double childRadius = this.parentData.radius + padding;
    double paddingTheta = math.atan(padding / (this.parentData.radius + deltaRadius));
    double innerTheta = paddingTheta; // increments with each child
    double remainingDeltaTheta = _constraints.maxDeltaTheta - (innerTheta + paddingTheta);
    RenderSector child = firstChild;
    while (child != null) {
      SectorConstraints innerConstraints = new SectorConstraints(
        maxDeltaRadius: innerDeltaRadius,
        maxDeltaTheta: remainingDeltaTheta
      );
      assert(child.parentData is SectorParentData);
      child.parentData.theta = innerTheta;
      child.parentData.radius = childRadius;
      child.layout(innerConstraints, relayoutSubtreeRoot: relayoutSubtreeRoot);
      innerTheta += child.deltaTheta;
      remainingDeltaTheta -= child.deltaTheta;
      assert(child.parentData is SectorChildListParentData);
      child = child.parentData.nextSibling;
      if (child != null) {
        innerTheta += paddingTheta;
        remainingDeltaTheta -= paddingTheta;
      }
    }
    deltaTheta = innerTheta;
  }

  // TODO(ianh): hit testing et al is pending on adam's patch

  // paint origin is 0,0 of our circle
  // each sector then knows how to paint itself at its location
  void paint(RenderNodeDisplayList canvas) {
    // TODO(ianh): avoid code duplication
    super.paint(canvas);
    RenderSector child = firstChild;
    while (child != null) {
      assert(child.parentData is SectorChildListParentData);
      canvas.paintChild(child, 0.0, 0.0);
      child = child.parentData.nextSibling;
    }
  }

}

class RenderSectorSlice extends RenderDecoratedSector with ContainerRenderNodeMixin<RenderSector, SectorChildListParentData> {
  // lays out RenderSector children in a stack

  RenderSectorSlice({
    BoxDecoration decoration,
    double deltaTheta: kTwoPi,
    double padding: 0.0
  }) : super(decoration), _padding = padding, _desiredDeltaTheta = deltaTheta;

  double _desiredDeltaTheta;
  double get desiredDeltaTheta => _desiredDeltaTheta;
  void set desiredDeltaTheta(double value) {
    assert(value != null);
    if (_desiredDeltaTheta != value) {
      _desiredDeltaTheta = value;
      markNeedsLayout();
    }
  }

  double _padding;
  double get padding => _padding;
  void set padding(double value) {
    // TODO(ianh): avoid code duplication
    assert(value != null);
    if (_padding != value) {
      _padding = value;
      markNeedsLayout();
    }
  }

  void setParentData(RenderNode child) {
    // TODO(ianh): avoid code duplication
    if (child.parentData is! SectorChildListParentData)
      child.parentData = new SectorChildListParentData();
  }

  SectorDimensions getIntrinsicDimensions(SectorConstraints constraints, double radius) {
    assert(this.parentData is SectorParentData);
    double paddingTheta = math.atan(padding / this.parentData.radius);
    double outerDeltaTheta = constraints.constrainDeltaTheta(desiredDeltaTheta);
    double innerDeltaTheta = outerDeltaTheta - paddingTheta * 2.0;
    double childRadius = this.parentData.radius + padding;
    double remainingDeltaRadius = constraints.maxDeltaRadius - (padding * 2.0);
    RenderSector child = firstChild;
    while (child != null) {
      SectorConstraints innerConstraints = new SectorConstraints(
        maxDeltaRadius: remainingDeltaRadius,
        maxDeltaTheta: innerDeltaTheta
      );
      SectorDimensions childDimensions = child.getIntrinsicDimensions(innerConstraints, childRadius);
      childRadius += childDimensions.deltaRadius;
      remainingDeltaRadius -= childDimensions.deltaRadius;
      assert(child.parentData is SectorChildListParentData);
      child = child.parentData.nextSibling;
      childRadius += padding;
      remainingDeltaRadius -= padding;
    }
    return new SectorDimensions.withConstraints(constraints,
                                                deltaRadius: childRadius - this.parentData.radius,
                                                deltaTheta: outerDeltaTheta);
  }

  SectorConstraints _constraints;
  void layout(SectorConstraints constraints, { RenderNode relayoutSubtreeRoot }) {
    if (relayoutSubtreeRoot != null)
      saveRelayoutSubtreeRoot(relayoutSubtreeRoot);
    relayoutSubtreeRoot = relayoutSubtreeRoot == null ? this : relayoutSubtreeRoot;
    deltaTheta = constraints.constrainDeltaTheta(desiredDeltaTheta);
    assert(deltaTheta <= kTwoPi);
    _constraints = constraints;
    internalLayout(relayoutSubtreeRoot);
  }

  void relayout() {
    // TODO(ianh): avoid code duplication
    assert(parentData is SectorParentData);
    internalLayout(this);
  }

  void internalLayout(RenderNode relayoutSubtreeRoot) {
    assert(this.parentData is SectorParentData);
    double paddingTheta = math.atan(padding / this.parentData.radius);
    double innerTheta = this.parentData.theta + paddingTheta;
    double innerDeltaTheta = deltaTheta - paddingTheta * 2.0;
    double childRadius = this.parentData.radius + padding;
    double remainingDeltaRadius = _constraints.maxDeltaRadius - (padding * 2.0);
    RenderSector child = firstChild;
    while (child != null) {
      SectorConstraints innerConstraints = new SectorConstraints(
        maxDeltaRadius: remainingDeltaRadius,
        maxDeltaTheta: innerDeltaTheta
      );
      child.parentData.theta = innerTheta;
      child.parentData.radius = childRadius;
      child.layout(innerConstraints);
      childRadius += child.deltaRadius;
      remainingDeltaRadius -= child.deltaRadius;
      assert(child.parentData is SectorChildListParentData);
      child = child.parentData.nextSibling;
      childRadius += padding;
      remainingDeltaRadius -= padding;
    }
    deltaRadius = childRadius - this.parentData.radius;
  }

  // TODO(ianh): hit testing et al is pending on adam's patch

  // paint origin is 0,0 of our circle
  // each sector then knows how to paint itself at its location
  void paint(RenderNodeDisplayList canvas) {
    // TODO(ianh): avoid code duplication
    super.paint(canvas);
    RenderSector child = firstChild;
    while (child != null) {
      assert(child.parentData is SectorChildListParentData);
      canvas.paintChild(child, 0.0, 0.0);
      child = child.parentData.nextSibling;
    }
  }

}

class RenderBoxToRenderSectorAdapter extends RenderBox {

  RenderBoxToRenderSectorAdapter({ double innerRadius: 0.0, RenderSector child }) :
    _innerRadius = innerRadius {
    _child = child;
    adoptChild(_child);
  }

  double _innerRadius;
  double get innerRadius => _innerRadius;
  void set innerRadius(double value) {
    _innerRadius = value;
    markNeedsLayout();
  }

  RenderSector _child;
  RenderSector get child => _child;
  void set child(RenderSector value) {
    if (_child != null)
      dropChild(_child);
    _child = value;
    adoptChild(_child);
    markNeedsLayout();
  }

  void setParentData(RenderNode child) {
    if (child.parentData is! SectorParentData)
      child.parentData = new SectorParentData();
  }

  BoxDimensions getIntrinsicDimensions(BoxConstraints constraints) {
    if (child == null)
      return new BoxDimensions.withConstraints(constraints, width: 0.0, height: 0.0);
    assert(child is RenderSector);
    assert(child.parentData is SectorParentData);
    assert(!constraints.isInfinite);
    double maxChildDeltaRadius = math.min(constraints.maxWidth, constraints.maxHeight) / 2.0 - innerRadius;
    SectorDimensions childDimensions = child.getIntrinsicDimensions(new SectorConstraints(maxDeltaRadius: maxChildDeltaRadius), innerRadius);
    double dimension = (innerRadius + childDimensions.deltaRadius) * 2.0;
    return new BoxDimensions.withConstraints(constraints, width: dimension, height: dimension);
  }

  void layout(BoxConstraints constraints, { RenderNode relayoutSubtreeRoot }) {
    if (relayoutSubtreeRoot != null)
      saveRelayoutSubtreeRoot(relayoutSubtreeRoot);
    relayoutSubtreeRoot = relayoutSubtreeRoot == null ? this : relayoutSubtreeRoot;
    BoxDimensions ourDimensions;
    if (child == null) {
      ourDimensions = new BoxDimensions.withConstraints(constraints, width: 0.0, height: 0.0);
    } else {
      assert(child is RenderSector);
      assert(!constraints.isInfinite);
      double maxChildDeltaRadius = math.min(constraints.maxWidth, constraints.maxHeight) / 2.0 - innerRadius;
      assert(child.parentData is SectorParentData);
      child.parentData.radius = innerRadius;
      child.parentData.theta = 0.0;
      child.layout(new SectorConstraints(maxDeltaRadius: maxChildDeltaRadius), relayoutSubtreeRoot: relayoutSubtreeRoot);
      double dimension = (innerRadius + child.deltaRadius) * 2.0;
      ourDimensions = new BoxDimensions.withConstraints(constraints, width: dimension, height: dimension);
    }
    width = ourDimensions.width;
    height = ourDimensions.height;
    layoutDone();
  }

  double width;
  double height;

  // TODO(ianh): hit testing et al is pending on adam's patch

  // paint origin is 0,0 of our circle
  void paint(RenderNodeDisplayList canvas) {
    super.paint(canvas);
    if (child != null)
      canvas.paintChild(child, width/2.0, height/2.0);
  }
  
}

class RenderSolidColor extends RenderDecoratedSector {
  RenderSolidColor(int backgroundColor, {
    this.desiredDeltaRadius: double.INFINITY,
    this.desiredDeltaTheta: kTwoPi
  }) : super(new BoxDecoration(backgroundColor: backgroundColor));

  double desiredDeltaRadius;
  double desiredDeltaTheta;

  SectorDimensions getIntrinsicDimensions(SectorConstraints constraints, double radius) {
    return new SectorDimensions.withConstraints(constraints, deltaTheta: 1.0); // 1.0 radians
  }

  void layout(SectorConstraints constraints, { RenderNode relayoutSubtreeRoot }) {
    deltaRadius = constraints.constrainDeltaRadius(desiredDeltaRadius);
    deltaTheta = constraints.constrainDeltaTheta(desiredDeltaTheta);
    layoutDone();
  }
}

RenderView renderView;

void beginFrame(double timeStamp) {
  RenderNode.flushLayout();

  renderView.paintFrame();
}

bool handleEvent(sky.Event event) {
  if (event is! sky.PointerEvent)
    return false;
  return renderView.handlePointer(event, x: event.x, y: event.y);
}

void main() {
  print("test...");
  sky.view.setEventCallback(handleEvent);
  sky.view.setBeginFrameCallback(beginFrame);

  var rootCircle = new RenderSectorRing(padding: 10.0);
  rootCircle.add(new RenderSolidColor(0xFF00FFFF, desiredDeltaTheta: kTwoPi * 0.25));
  rootCircle.add(new RenderSolidColor(0xFF0000FF, desiredDeltaTheta: kTwoPi * 0.3));
  var stack = new RenderSectorSlice(padding: 10.0);
  stack.add(new RenderSolidColor(0xFFFFFF00, desiredDeltaRadius: 20.0));
  stack.add(new RenderSolidColor(0xFFFF9000, desiredDeltaRadius: 20.0));
  stack.add(new RenderSolidColor(0xFF00FF00, desiredDeltaRadius: 20.0));
  rootCircle.add(stack);

  var root = new RenderBoxToRenderSectorAdapter(innerRadius: 50.0, child: rootCircle);
  renderView = new RenderView(root: root);
  renderView.layout(newWidth: sky.view.width, newHeight: sky.view.height);

  sky.view.scheduleFrame();
}
