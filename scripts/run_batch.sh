#!/bin/bash
# ============================================================
# 日本版CardDemo バッチ実行スクリプト
#   AWS CardDemoと同一構成のリポジトリから、英字名版バッチを
#   GnuCOBOLでビルド・実行する(実行検証用)。
#   日本語データ名版(顧客帳票.cbl/漢字解析.cbl + 日本語コピー句)は
#   IBM Enterprise COBOL for z/OS の DBCS 利用者語(日本語データ名)を想定。
# ============================================================
set -e
cd "$(dirname "$0")/.."
ROOT="$(pwd)"
WORK="$(mktemp -d /tmp/jcd.XXXXXX)"; cd "$WORK"

# 全コピー句・英字名プログラム・データ生成スクリプトを集約
find "$ROOT/app" -name "*.cpy" -exec cp {} . \; 2>/dev/null
find "$ROOT/app" -name "*.cbl" ! -name "顧客帳票.cbl" ! -name "漢字解析.cbl" -exec cp {} . \; 2>/dev/null
cp "$ROOT/app/data/"*.py . 2>/dev/null || true

echo "=== 日本版CardDemo バッチ実行 ==="
cobc -m JCKANJ0C.cbl 2>/dev/null
export COB_LIBRARY_PATH="$WORK"
run() { cobc -x -I. "$1.cbl" 2>/dev/null; ./"$1"; }

python3 gen_custj.py 50 >/dev/null; run CBCUSJ1C
echo "顧客帳票:   $(tail -1 custjrpt.out)"
python3 gen_fullset_data.py pauth 20 >/dev/null; run CBPAUJ0C
echo "与信明細:   $(tail -1 pauthjrpt.out)"
python3 gen_fullset_data.py acctmq 20 >/dev/null; run COACCJ01
echo "口座MQ連携: $(tail -1 acctmqj.out)"
python3 gen_fullset_data.py trantype 20 >/dev/null; run COBTUPJT
echo "取引タイプ: $(tail -1 trantypejrpt.out)"
echo "=== 完了 ==="
