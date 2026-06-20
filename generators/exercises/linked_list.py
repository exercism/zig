HEADER = "const List = linked_list.LinkedList(usize);"
IMPORT_SELF = True


def describe(case, parent):
    return case["description"]


_NAMES = "abcdefghijklmnopqrstuvwxyz"


def gen_case(case):
    ops = case["input"]["operations"]

    # A node variable is declared for every value introduced by push/unshift, in order.
    # delete(value) targets the first not-yet-deleted node holding that value.
    nodes = []  # list of (name, value)
    plan = []  # list of (kind, payload)
    deleted = set()

    for op in ops:
        kind = op["operation"]
        if kind in ("push", "unshift"):
            name = _NAMES[len(nodes)]
            nodes.append((name, op["value"]))
            plan.append((kind, name))
        elif kind == "delete":
            value = op["value"]
            target = None
            for i, (name, val) in enumerate(nodes):
                if val == value and i not in deleted:
                    target = name
                    deleted.add(i)
                    break
            if target is None:
                # Deleting a value not in the list: still declare a node holding it.
                target = _NAMES[len(nodes)]
                nodes.append((target, value))
                deleted.add(len(nodes) - 1)
            plan.append(("delete", target))
        elif kind in ("pop", "shift"):
            plan.append((kind, op.get("expected")))
        elif kind == "count":
            plan.append(("count", op["expected"]))

    mutates = any(k != "count" for k, _ in plan)
    lines = []
    lines.append(f"    {'var' if mutates else 'const'} list = List{{}};")
    for name, value in nodes:
        lines.append(f"    var {name} = List.Node{{ .data = {value} }};")

    for kind, payload in plan:
        if kind in ("push", "unshift"):
            lines.append(f"    list.{kind}(&{payload});")
        elif kind == "delete":
            lines.append(f"    list.delete(&{payload});")
        elif kind in ("pop", "shift"):
            if payload is None:
                lines.append(f"    _ = list.{kind}();")
            else:
                lines.append(
                    f"    try testing.expectEqual(@as(usize, {payload}), list.{kind}().?.data);"
                )
        elif kind == "count":
            lines.append(
                f"    try testing.expectEqual(@as(usize, {payload}), list.len);"
            )

    return "\n".join(lines) + "\n"
