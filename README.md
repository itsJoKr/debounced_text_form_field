![debounced_field_title.png](images%2Fdebounced_field_title.png)

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
  validator: Validator.mustBeEmail(context),
),
```

You can change debounce duration. Default is 1s as that's a good balance since you want to give user time to finish typing.

```dart
DebouncedTextFormField(
  debounceDuration: Duration(milliseconds: 500),
  validator: Validator.mustBeEmail(context),
),
```

**Special case:**

- The validation is run immediately when the field has correct value or when it's empty. This is to provide immediate feedback to the user that his input is valid.
- There is no autovalidateMode parameter from TextFormField, as debouncing is a form of auto-validation.

---

Maintained by: contact@joe-it-solutions.com

![footer.png](images%2Ffooter.png)