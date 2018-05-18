/*
 * C 言語による Quine 。
 * コンパイルし実行すると、このソースコードと同じものが標準出力に出力される。
 */
int main(){char *s="int main(){char *s=%c%s%c;printf(s,34,s,34);}";printf(s,34,s,34);}

