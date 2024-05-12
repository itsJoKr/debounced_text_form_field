![debounced_field_title.png](images%2Fdebounced_field_title.png)

Drop in replacement for `TextFormField` that debounces the validation.

## Motivation

While there are other debouncing packages available, this one builds on foundation of Form and validation provided by Flutter. 
Just replace your `TextFormField` with `DebouncedTextFormField` and you are good to go. No extra widgets or builders needed.

```dart
DebouncedFormField(
  decoration: const InputDecoration(
    hintText: 'Enter email',
    prefixIcon: Icon(Icons.mail),
  ),
  validator: Validator.mustBeEmail(context),
  ),
```

Maintained by: contact@joe-it-solutions.com

![debounced_field_footer.png](images%2Fdebounced_field_footer.png)