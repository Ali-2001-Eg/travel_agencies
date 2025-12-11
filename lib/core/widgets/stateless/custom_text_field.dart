part of '../widgets.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool filled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          LocalizedLabel(
            text: widget.labelText!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          style: widget.textStyle ?? context.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hintText?.tr(),
            prefixText: widget.prefixText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color:
                          context.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            filled: widget.filled,
            fillColor: widget.fillColor ?? context.colorScheme.surface,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colorScheme.primary,
                    width: 2,
                  ),
                ),
            errorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                  ),
                ),
            hintStyle: widget.hintStyle ??
                context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
            labelStyle: widget.labelStyle,
          ),
        ),
      ],
    );
  }
}
