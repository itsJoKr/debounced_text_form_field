library debounced_text_form_field;

import 'dart:async';

import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// DebouncedFormField designed as a drop-in replacement for TextFormField.
///
/// All the fields are same except that there is no 'autovalidateMode' since the debouncing itself is a form of auto-validation.
///
/// - [onChanged] is called whenever the value changes, only errorText is being debounced.
/// - In case of empty field or no error, the field is validated immediately.
/// This is usually UX you want to have to immediately remove error text. And debounce errors while user is typing.
class DebouncedFormField extends FormField<String> {
  DebouncedFormField({
    super.key,
    this.onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool obscureText = false,
    super.initialValue,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    int? minLines,
    super.enabled,
    bool required = false,
    super.validator,
    void Function(String)? onFieldSubmitted,
    Color? backgroundColor,
    InputDecoration? decoration,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    super.onSaved,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    UndoHistoryController? undoController,
    AppPrivateCommandCallback? onAppPrivateCommand,
    bool? cursorOpacityAnimates,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    Clip clipBehavior = Clip.hardEdge,
    bool scribbleEnabled = true,
    bool canRequestFocus = true,
  }) : super(
          builder: (formFieldState) {
            return TextFormField(
              decoration: decoration?.copyWith(
                    // errorText has priority, if developer sets it
                    errorText: decoration.errorText ?? formFieldState.errorText,
                  ) ??
                  InputDecoration(errorText: formFieldState.errorText),
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              autofocus: autofocus,
              obscureText: obscureText,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              minLines: minLines,
              enabled: enabled,
              onChanged: formFieldState.didChange,
              onFieldSubmitted: onFieldSubmitted,
              style: style,
              strutStyle: strutStyle,
              textDirection: textDirection,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              readOnly: readOnly,
              showCursor: showCursor,
              obscuringCharacter: obscuringCharacter,
              textCapitalization: textCapitalization,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              expands: expands,
              maxLength: maxLength,
              onTap: onTap,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              keyboardAppearance: keyboardAppearance,
              scrollPadding: scrollPadding,
              enableInteractiveSelection: enableInteractiveSelection,
              selectionControls: selectionControls,
              buildCounter: buildCounter,
              scrollPhysics: scrollPhysics,
              autofillHints: autofillHints,
              scrollController: scrollController,
              restorationId: restorationId,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              mouseCursor: mouseCursor,
              contextMenuBuilder: contextMenuBuilder,
              spellCheckConfiguration: spellCheckConfiguration,
              magnifierConfiguration: magnifierConfiguration,
              undoController: undoController,
              onAppPrivateCommand: onAppPrivateCommand,
              cursorOpacityAnimates: cursorOpacityAnimates,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              dragStartBehavior: dragStartBehavior,
              contentInsertionConfiguration: contentInsertionConfiguration,
              clipBehavior: clipBehavior,
              scribbleEnabled: scribbleEnabled,
              canRequestFocus: canRequestFocus,
            );
          },
        );

  final ValueChanged<String>? onChanged;

  @override
  FormFieldState<String> createState() => _DebouncedFormFieldState();
}

class _DebouncedFormFieldState extends FormFieldState<String> {
  static const _debounceDuration = Duration(milliseconds: 1000);

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    final widget = super.widget as DebouncedFormField;
    if (widget.initialValue != null) {
      setValue(widget.initialValue);
    }
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    final widget = super.widget as DebouncedFormField;

    if (value != null) {
      final hasError = widget.validator!(value) != null;
      if (!hasError || value.isEmpty) {
        // Validate immediately to remove error text
        super.validate();
      } else {
        // If there's an error, we debounce it
        _debounceTimer?.cancel();
        _debounceTimer = Timer(_debounceDuration, _onDebounceTimerFinished);
      }
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value!);
    }
  }

  void _onDebounceTimerFinished() {
    super.validate();
  }

  @override
  void didUpdateWidget(DebouncedFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
