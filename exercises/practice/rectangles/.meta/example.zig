/// Returns the number of rectangles in the ASCII diagram `strings`.
pub fn rectangles(strings: []const []const u8) usize {
    const rows: usize = strings.len;
    if (rows == 0) {
        return 0;
    }

    const columns: usize = strings[0].len;
    if (columns == 0) {
        return 0;
    }

    var count: usize = 0;
    for (0..rows) |top| {
        for (0..columns) |left| {
            const top_left = strings[top][left];
            if (top_left != '+') {
                continue;
            }

            for ((top + 1)..rows) |bottom| {
                const bottom_left = strings[bottom][left];
                if (bottom_left != '+') {
                    if (bottom_left != '|') {
                        break;
                    }

                    continue;
                }

                for ((left + 1)..columns) |right| {
                    const top_right = strings[top][right];
                    const bottom_right = strings[bottom][right];
                    if (top_right != '+' or bottom_right != '+') {
                        if ((top_right != '+' and top_right != '-') or (bottom_right != '+' and bottom_right != '-')) {
                            break;
                        }

                        continue;
                    }

                    for ((top + 1)..bottom) |row| {
                        const row_right = strings[row][right];
                        if (row_right != '+' and row_right != '|') {
                            break;
                        }
                    } else {
                        count += 1;
                    }
                }
            }
        }
    }
    return count;
}
