package main

import (
    "fmt"
    "strings"
    "sort"
    "strconv"
)

type EmojiUser struct {
    Name string
    Emojis []string
}

type EmojiUsers []EmojiUser

func (e EmojiUsers) Len() int {
    return len(e)
}

func (e EmojiUsers) Swap(i, j int) {
    e[i], e[j] = e[j], e[i]
}

type ByEmojisSize struct {
    EmojiUsers
}

func (b ByEmojisSize) Less(i, j int) bool {
    return len(b.EmojiUsers[i].Emojis) < len(b.EmojiUsers[j].Emojis)
}

func input() (results []string) {
    for {
        var line string
        if _, err := fmt.Scanln(&line); err != nil {
            return
        }
        results = append(results, line)
    }
}

func uniqueStrings(args []string) (results []string) {
    encounterd := map[string]bool{}
    for _, arg := range args {
        if !encounterd[arg] {
            encounterd[arg] = true
            results = append(results, arg)
        }
    }
    return
}

func main() {
    input_data := input()
    var emojiUsers EmojiUsers = make([]EmojiUser, 0, len(input_data))
    for _, line := range input_data {
        split_data := strings.Split(line, ",")
        emojiUsers = append(emojiUsers, EmojiUser{split_data[0], uniqueStrings(split_data[1:])})
    }
    sort.Sort(sort.Reverse(ByEmojisSize{emojiUsers}))
    for _, emojiUser := range emojiUsers {
        fmt.Println(emojiUser.Name + "," + strconv.Itoa(len(emojiUser.Emojis)));
    }
}