import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class FormFilledWidget extends StatelessWidget {

  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String hint;
  final String initialvalue;
  final bool obscure;
  final TextInputType keyboardType;
  final ValueChanged<String> onsubmit;
  final VoidCallback oncomplete;
  final ValueChanged<String> onchange;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final IconButton icon;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String labelText;
  final TextStyle labelStyle;
  final bool enabled;
  final bool readonly;
  final bool autofocus;
  final bool filled;
  final Color fillColor;
  final GestureTapCallback onTap;
  List<TextInputFormatter> inputFormatters;

  FormFilledWidget({
    this.textEditingController,
    this.hint,
    this.initialvalue,
    this.obscure,
    this.keyboardType,
    this.focusNode,
    this.onsubmit,
    this.onchange,
    this.oncomplete,
    this.textInputAction,
    this.validator,
    this.icon,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.labelStyle,
    this.enabled,
    this.readonly,
    this.autofocus,
    this.filled,
    this.fillColor,
    this.inputFormatters,
    this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onchange,
      readOnly: readonly == null ? false : readonly,
      autofocus: autofocus == null ? false : autofocus,
      controller: textEditingController,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      obscureText: obscure,
      focusNode: focusNode,
      initialValue: initialvalue,
      onFieldSubmitted: onsubmit,
      onEditingComplete: oncomplete,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: filled,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: labelStyle,
          alignLabelWithHint: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusColor: MyColors.dnaGreen,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[200], fontSize: 12)),
    );
    //formPhone(context);
  }
}