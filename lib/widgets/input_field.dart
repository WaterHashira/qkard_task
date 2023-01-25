import 'package:qkard_task/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    this.title,
    this.titleRightWidget,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onTap,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.defaultValue,
    this.controller,
    this.titleStyle,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.visibleValidators = const [],
    this.autofocus = false,
    this.isSensitive = false,
  }) : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final String? defaultValue;
  final String? hintText;
  final List<VisibleValidator> visibleValidators;
  final bool isSensitive;
  final TextEditingController? controller;
  final int maxLines;
  final bool autofocus;
  final bool? readOnly;
  final Widget? titleRightWidget;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final String? Function(String? value)? validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;
  bool _showVisibleValidators = false;

  String? _input;

  FocusNode? _focusNode;

  @override
  void initState() {
    if (widget.isSensitive) _obscureText = true;

    if (widget.visibleValidators.isNotEmpty) {
      _focusNode = FocusNode();

      _focusNode!.addListener(() {
        _showVisibleValidators = _focusNode!.hasFocus;
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: widget.titleStyle ??
                    Theme.of(
                      context,
                    ).textTheme.headline6,
              ),
              if (widget.titleRightWidget != null) widget.titleRightWidget!,
            ],
          ),
          if (widget.titleRightWidget == null) const SizedBox(height: 10),
        ],
        TextFormField(
          initialValue: widget.defaultValue,
          readOnly: widget.readOnly ?? widget.onTap != null,
          onTap: widget.onTap,
          textCapitalization: widget.textCapitalization,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          controller: widget.controller,
          onChanged: (v) {
            _input = v;
            if (_showVisibleValidators) setState(() {});
            return widget.onChanged?.call(v);
          },
          autofocus: widget.autofocus,
          validator: (v) {
            if (widget.visibleValidators.isNotEmpty &&
                !widget.visibleValidators
                    .every((element) => element.validatesToTrueIf(_input))) {
              return 'All the conditions are not met!';
            } else {
              return widget.validator?.call(v);
            }
          },
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: _obscureText,
          obscuringCharacter: '*',
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.subtitle2,
          decoration: InputDecoration(
            hintText: widget.hintText ??
                (widget.title == null
                    ? null
                    : 'Enter your ${widget.title!.toLowerCase()}'),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isSensitive
                ? IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () => setState(
                      () => _obscureText = !_obscureText,
                    ),
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                  )
                : widget.suffixIcon,
          ),
        ),
        if (_showVisibleValidators)
          ...widget.visibleValidators.map(
            (validator) {
              final isValidated = validator.validatesToTrueIf(_input);
              final color = isValidated
                  ? Theme.of(context).appStyle.successColor
                  : Theme.of(context).appStyle.errorColor;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(
                      isValidated ? Icons.check : Icons.clear,
                      color: color,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        validator.title,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: color),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class VisibleValidator {
  final String title;
  final bool Function(String?) validatesToTrueIf;

  VisibleValidator({
    required this.title,
    required this.validatesToTrueIf,
  });
}
