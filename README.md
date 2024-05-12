
![debounced_field_title](https://github.com/itsJoKr/debounced_text_form_field/assets/11093480/c0b4e274-6fff-4b2c-96c0-fe1bac877200)

Drop in replacement for `TextFormField` that debounces the validation.

## Motivation

While there are other debouncing packages available, this one builds on foundation of Form and validation provided by Flutter. 

Just replace your `TextFormField` with `DebouncedTextFormField` and you are good to go. No extra widgets or builders needed.

```dart
DebouncedTextFormField(
  decoration: const InputDecoration(
    hintText: 'Enter email',
    prefixIcon: Icon(Icons.mail),
  ),
  validator: (value) => _mustBeValidEmail(value),
),
```

You can change debounce duration. Default is 1s as that's a good balance since you want to give user time to finish typing.

```dart
DebouncedTextFormField(
  debounceDuration: Duration(milliseconds: 500),
),
```

**Special case:**

- The validation is run immediately when the field has correct value or when it's empty. This is to provide immediate feedback to the user that his input is valid.
- There is no autovalidateMode parameter from TextFormField, as debouncing is a form of auto-validation.

---

Maintained by: contact@joe-it-solutions.com

![debounced_field_footer](https://github.com/itsJoKr/debounced_text_form_field/assets/11093480/abf1e009-2d4b-44b0-a8a2-49541f8291f5)
