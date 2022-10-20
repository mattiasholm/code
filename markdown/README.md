# Cheat Sheet - Markdown

<br>

# Heading 1:
```markdown
# Heading 1

-OR-

Heading 1
=========
```

## Heading 2:
```markdown
## Heading 2

-OR-

Heading 2
---------
```

### Heading 3
```markdown
### Heading 3
```

#### Heading 4
```markdown
#### Heading 4
```

##### Heading 5
```markdown
##### Heading 5
```

###### Heading 6
```markdown
###### Heading 6
```

<br><br>

Regular text
```markdown
Regular text
```

**Bold text**
```markdown
**Bold text**

-OR-

__Bold text__
```

*Italic text*
```markdown
*Italic text*

-OR-

_Italic text_
```

~~Strikethrough text~~
```markdown
~~Strikethrough text~~
```

***Bold and italic text***
```markdown
***Bold and italic text***

-OR-

___Bold and italic text___
```

`Highlighted text`
```markdown
`Highlighted text`
```

\#

\-

\*

\+

\|
```markdown
\#

\-

\*

\+

\|
```

<br><br>

```bash
echo "string"
```
~~~markdown
```bash
echo "string"
```
~~~
-OR-
```markdown
~~~bash
echo "string"
~~~
```

<br><br>

[Named Link](https://www.google.com) and https://www.google.com or <info@example.com>
```markdown
[Named Link](https://www.google.com) and https://www.google.com or <info@example.com>
```

<br><br>

| Left-aligned Header | Left-aligned Header | Centered Header | Right-aligned Header |
| ------------------- | :------------------ | :-------------: | -------------------: |
| Content Cell        | Content Cell        |  Content Cell   |         Content Cell |
| Content Cell        | Content Cell        |  Content Cell   |         Content Cell |
```markdown
| Left-aligned Header | Left-aligned Header | Centered Header | Right-aligned Header |
| ------------------- | :------------------ | :-------------: | -------------------: |
| Content Cell        | Content Cell        |  Content Cell   |         Content Cell |
| Content Cell        | Content Cell        |  Content Cell   |         Content Cell |
```

<br><br>

- An
  - Unordered
    - Bullet List
```markdown
- An
  - Unordered
    - Bullet List

-OR-

* An
  * Unordered
    * Bullet List

-OR

+ An
  + Unordered
    + Bullet List
```

<br><br>

1. A numbered list
   1. A nested numbered list
   2. Which is numbered
2. Which is numbered
```markdown
1. A numbered list
   1. A nested numbered list
   2. Which is numbered
2. Which is numbered
```

<br><br>

- [ ] An uncompleted task
- [x] A completed task
```markdown
- [ ] An uncompleted task
- [x] A completed task
```

<br><br>

> Blockquote
>> Nested blockquote
>>
>> With multiple lines
```markdown
> Blockquote
>> Nested blockquote
>>
>> With multiple lines
```

<br><br>

---
```markdown
---

-OR-

- - -

-OR-

***

-OR-

* * *

-OR-

___

-OR-

_ _ _
```

<br><br>

![Image alt text](https://www.google.se/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png)
```markdown
![Image alt text](https://www.google.se/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png)
```

<br><br>

<img src="https://www.google.se/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png" alt="Image alt text" width="200"/>

```markdown
<img src="https://www.google.se/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png" alt="Image alt text" width="200"/>
```

<br><br>

<details>
  <summary>Foldable text</summary>
  <p>Text only visible when expanded</p>
</details>

```markdown
<details>
  <summary>Foldable text</summary>
  <p>Text only visible when expanded</p>
</details>
```

<br><br>

<kbd>⌘F</kbd>
```markdown
<kbd>⌘F</kbd>
```

| Key       | Symbol |
| --------- | ------ |
| Option    | ⌥      |
| Control   | ⌃      |
| Command   | ⌘      |
| Shift     | ⇧      |
| Caps Lock | ⇪      |
| Tab       | ⇥      |
| Esc       | ⎋      |
| Power     | ⌽      |
| Return    | ↩      |
| Delete    | ⌫      |
| Up        | ↑      |
| Down      | ↓      |
| Left      | ←      |
| Right     | →      |

<br><br>
:white_check_mark: :x:
```markdown
:white_check_mark: :x:
```

[Emojipedia](https://emojipedia.org/)

<br><br>

<!-- https://mermaid-js.github.io/mermaid/#/flowchart -->
Flowchart (left to right):  
```mermaid
flowchart LR
  step1 --> step2 --> step3[This is the third step] --> step4(This is the text in the box)
```

<br>

Flowchart (top to bottom):  
```mermaid
flowchart TB
    step1 --> step2 --> step3[This is the third step] --> step4(This is the text in the box)
```

<!--  -->
<br><br>

Footnote[^1]

[^1]: This is the first footnote.

```markdown
Footnote[^1]

[^1]: This is the first footnote.
```