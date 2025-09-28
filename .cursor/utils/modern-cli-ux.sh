#!/bin/bash

# 🎨 Modern CLI UX Utilities for Git Flow Commands
# Sistema Onion - GitFlow Guardian with Modern User Experience

# Color definitions (follow modern CLI standards)
RED='\033[0;31m'
GREEN='\033[0;32m' 
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GRAY='\033[0;90m'
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'
NC='\033[0m' # No Color

# Initialize start time for performance tracking
START_TIME=${START_TIME:-$(date +%s)}

# =============================================================================
# HEADER AND LAYOUT FUNCTIONS
# =============================================================================

cli_header() {
    local text="$1"
    local color="${2:-cyan}"
    
    case $color in
        "cyan") echo -e "\n${CYAN}${BOLD}$text${NC}" ;;
        "green") echo -e "\n${GREEN}${BOLD}$text${NC}" ;;
        "yellow") echo -e "\n${YELLOW}${BOLD}$text${NC}" ;;
        "red") echo -e "\n${RED}${BOLD}$text${NC}" ;;
        *) echo -e "\n${BOLD}$text${NC}" ;;
    esac
}

cli_section_header() {
    local text="$1"
    echo -e "\n${GREEN}$text${NC}"
}

cli_separator() {
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

cli_separator_thick() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

cli_success_header() {
    local text="$1"
    echo -e "${GREEN}${BOLD}$text${NC}"
}

cli_error_header() {
    local text="$1"
    echo -e "${RED}${BOLD}$text${NC}"
}

# =============================================================================
# STATUS AND INDICATOR FUNCTIONS
# =============================================================================

cli_status_line() {
    local label="$1"
    local status="$2" 
    local color="$3"
    
    case $color in
        "green") echo -e "   ▶ $label: ${GREEN}$status${NC}" ;;
        "red") echo -e "   ▶ $label: ${RED}$status${NC}" ;;
        "yellow") echo -e "   ▶ $label: ${YELLOW}$status${NC}" ;;
        "blue") echo -e "   ▶ $label: ${BLUE}$status${NC}" ;;
        "cyan") echo -e "   ▶ $label: ${CYAN}$status${NC}" ;;
        "dim") echo -e "   ▶ $label: ${DIM}$status${NC}" ;;
        *) echo "   ▶ $label: $status" ;;
    esac
}

cli_bullet_point() {
    local text="$1"
    local color="${2:-white}"
    
    case $color in
        "green") echo -e "   ∟ ${GREEN}$text${NC}" ;;
        "red") echo -e "   ∟ ${RED}$text${NC}" ;;
        "yellow") echo -e "   ∟ ${YELLOW}$text${NC}" ;;
        "cyan") echo -e "   ∟ ${CYAN}$text${NC}" ;;
        "dim") echo -e "   ∟ ${DIM}$text${NC}" ;;
        *) echo "   ∟ $text" ;;
    esac
}

# =============================================================================
# PROGRESS INDICATOR FUNCTIONS
# =============================================================================

cli_progress_start() {
    local message="$1"
    echo -ne "   ⏳ $message... "
}

cli_progress_success() {
    local message="$1"
    echo -e "${GREEN}✅ $message${NC}"
}

cli_progress_error() {
    local message="$1"
    echo -e "${RED}❌ $message${NC}"
}

cli_progress_warning() {
    local message="$1"
    echo -e "${YELLOW}⚠️ $message${NC}"
}

cli_progress_info() {
    local message="$1"
    echo -e "${CYAN}ℹ️ $message${NC}"
}

cli_progress_step() {
    local step="$1"
    local total="$2"
    local message="$3"
    echo -e "${CYAN}🚀 STEP ($step/$total): $message${NC}"
}

# =============================================================================
# TEXT FORMATTING AND HIGHLIGHTING
# =============================================================================

cli_highlight() {
    local text="$1"
    local color="${2:-yellow}"
    
    case $color in
        "green") echo -e "${GREEN}$text${NC}" ;;
        "red") echo -e "${RED}$text${NC}" ;;
        "yellow") echo -e "${YELLOW}$text${NC}" ;;
        "cyan") echo -e "${CYAN}$text${NC}" ;;
        "blue") echo -e "${BLUE}$text${NC}" ;;
        "magenta") echo -e "${MAGENTA}$text${NC}" ;;
        "bold") echo -e "${BOLD}$text${NC}" ;;
        "underline") echo -e "${UNDERLINE}$text${NC}" ;;
        *) echo "$text" ;;
    esac
}

cli_dim() {
    local text="$1"
    echo -e "${DIM}$text${NC}"
}

cli_bold() {
    local text="$1"
    echo -e "${BOLD}$text${NC}"
}

cli_emphasis() {
    local text="$1"
    echo -e "${CYAN}${BOLD}$text${NC}"
}

# =============================================================================
# BOX AND ALERT FUNCTIONS
# =============================================================================

cli_error_box() {
    local title="$1"
    local message="$2"
    echo ""
    echo -e "${RED}${BOLD}🚨 $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_warning_box() {
    local title="$1" 
    local message="$2"
    echo ""
    echo -e "${YELLOW}${BOLD}⚠️ $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_info_box() {
    local title="$1"
    local message="$2"
    echo ""
    echo -e "${CYAN}${BOLD}ℹ️ $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_success_box() {
    local title="$1"
    local message="$2"
    echo ""
    echo -e "${GREEN}${BOLD}✅ $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_critical_warning_box() {
    local message="$1"
    echo ""
    echo -e "${RED}${BOLD}⚠️ $message${NC}"
    echo ""
}

cli_education_box() {
    local title="$1"
    local content="$2"
    echo ""
    echo -e "${CYAN}🎓 ${BOLD}$title${NC}"
    echo -e "${DIM}$content${NC}"
}

# =============================================================================
# INTERACTIVE CONFIRMATION FUNCTIONS
# =============================================================================

cli_confirm_critical() {
    local message="$1"
    local default="${2:-N}" # Default to NO for safety
    
    echo ""
    cli_critical_warning_box "CRITICAL OPERATION - CANNOT BE UNDONE"
    echo -e "${RED}$message${NC}"
    echo ""
    echo -n "❓ $(cli_highlight "Proceed?" "yellow") [y/N] "
    
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        return 0  # User confirmed
    else
        return 1  # User cancelled
    fi
}

cli_confirm_default_yes() {
    local message="$1"
    echo -n "❓ $message [Y/n] "
    
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        return 1  # User declined
    else
        return 0  # User confirmed (default yes)
    fi
}

cli_confirm_default_no() {
    local message="$1"
    echo -n "❓ $message [y/N] "
    
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        return 0  # User confirmed
    else
        return 1  # User declined (default no)
    fi
}

# =============================================================================
# GIT FLOW SPECIFIC FUNCTIONS
# =============================================================================

cli_gitflow_workflow_display() {
    local current_step="$1"
    local feature_name="$2"
    
    echo ""
    cli_section_header "🎓 GIT FLOW WORKFLOW"
    
    case $current_step in
        "feature_finish")
            echo -e "$(cli_dim "   develop") → $(cli_highlight "feature/$feature_name" "yellow") → $(cli_dim "develop") ← you are here"
            ;;
        "release_start")
            echo -e "$(cli_dim "   develop") → $(cli_highlight "release/version" "yellow") → $(cli_dim "main + develop")"
            ;;
        "hotfix_start") 
            echo -e "$(cli_dim "   main") → $(cli_highlight "hotfix/fix" "red") → $(cli_dim "main + develop")"
            ;;
    esac
    
    echo ""
    echo -e "$(cli_dim "This follows the official Git Flow model by Vincent Driessen")"
}

cli_git_impact_preview() {
    local source_branch="$1"
    local target_branch="$2"
    
    echo ""
    cli_section_header "🔍 IMPACT PREVIEW"
    
    # Count commits
    local commit_count
    commit_count=$(git rev-list --count "HEAD" ^"$target_branch" 2>/dev/null || echo "0")
    echo "   ▶ Commits to merge: $commit_count commits"
    
    # Count files
    local file_count
    file_count=$(git diff --name-only "$target_branch..HEAD" 2>/dev/null | wc -l)
    echo "   ▶ Files affected: $file_count files"
    
    # Show diff stats
    local diff_stats
    diff_stats=$(git diff --stat "$target_branch..HEAD" 2>/dev/null | tail -1)
    if [ -n "$diff_stats" ]; then
        echo "   ▶ Changes: $diff_stats"
    fi
    
    # Show modified files (first 10)
    echo ""
    echo "📁 Modified files:"
    git diff --name-only "$target_branch..HEAD" 2>/dev/null | head -10 | while read -r file; do
        echo "   ∟ $(cli_dim "$file")"
    done
    
    # Show ... more if applicable
    local total_files
    total_files=$(git diff --name-only "$target_branch..HEAD" 2>/dev/null | wc -l)
    if [ "$total_files" -gt 10 ]; then
        echo "   $(cli_dim "... and $((total_files - 10)) more files")"
    fi
}

# =============================================================================
# VALIDATION FUNCTIONS
# =============================================================================

cli_validate_git_working_directory() {
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        cli_status_line "Working directory" "❌ Uncommitted changes" "red"
        return 1
    else
        cli_status_line "Working directory" "✅ Clean" "green"
        return 0
    fi
}

cli_validate_branch_exists() {
    local branch_name="$1"
    local location="${2:-local}" # local, remote, or both
    
    case $location in
        "local")
            if git branch | grep -q "$branch_name"; then
                return 0
            else
                return 1
            fi
            ;;
        "remote")
            if git branch -r | grep -q "origin/$branch_name"; then
                return 0
            else
                return 1
            fi
            ;;
        "both")
            if git branch -a | grep -q "$branch_name"; then
                return 0
            else
                return 1
            fi
            ;;
    esac
}

cli_validate_merge_conflicts() {
    local source_branch="$1"
    local target_branch="$2"
    
    # Create temporary merge check
    local merge_check_file="/tmp/gitflow_merge_check_$$"
    git merge-tree "$(git merge-base "$target_branch" "$source_branch")" "$target_branch" "$source_branch" > "$merge_check_file" 2>/dev/null
    
    if grep -q "<<<<<<< " "$merge_check_file"; then
        cli_status_line "Merge conflicts" "❌ Conflicts detected" "red"
        rm -f "$merge_check_file"
        return 1
    else
        cli_status_line "Merge conflicts" "✅ None detected" "green"
        rm -f "$merge_check_file"
        return 0
    fi
}

# =============================================================================
# CLICKUP INTEGRATION FUNCTIONS
# =============================================================================

clickup_update_task() {
    local task_id="$1"
    local status="$2"
    local retry_count="${3:-2}"
    
    if [ -z "$CLICKUP_TOKEN" ]; then
        return 1
    fi
    
    for i in $(seq 1 $retry_count); do
        if curl -s -X PUT "https://api.clickup.com/api/v2/task/$task_id" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"status\": \"$status\"}" > /dev/null 2>&1; then
            return 0
        fi
        
        if [ $i -lt $retry_count ]; then
            sleep 1
        fi
    done
    
    return 1
}

clickup_add_comment() {
    local task_id="$1" 
    local comment="$2"
    local retry_count="${3:-2}"
    
    if [ -z "$CLICKUP_TOKEN" ]; then
        return 1
    fi
    
    # Escape quotes in comment for JSON
    local escaped_comment
    escaped_comment=$(echo "$comment" | sed 's/"/\\"/g')
    
    for i in $(seq 1 $retry_count); do
        if curl -s -X POST "https://api.clickup.com/api/v2/task/$task_id/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\": \"$escaped_comment\"}" > /dev/null 2>&1; then
            return 0
        fi
        
        if [ $i -lt $retry_count ]; then
            sleep 1
        fi
    done
    
    return 1
}

clickup_get_task_id_from_session() {
    # Look for task ID in session context files
    local task_id=""
    
    # Try different patterns and locations
    if [ -d ".cursor/sessions" ]; then
        # Look for "Task ID:" pattern
        task_id=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | \
                 head -1 | xargs grep -i "task id:" 2>/dev/null | \
                 cut -d: -f2 | xargs 2>/dev/null)
        
        # If not found, try "ID:" pattern
        if [ -z "$task_id" ]; then
            task_id=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | \
                     head -1 | xargs grep -i "id:" 2>/dev/null | \
                     cut -d: -f2 | xargs 2>/dev/null)
        fi
        
        # If not found, try "ClickUp:" pattern
        if [ -z "$task_id" ]; then
            task_id=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | \
                     head -1 | xargs grep -i "clickup:" 2>/dev/null | \
                     cut -d: -f2 | xargs 2>/dev/null)
        fi
    fi
    
    echo "$task_id"
}

# =============================================================================
# PERFORMANCE AND TIMING FUNCTIONS
# =============================================================================

cli_performance_start() {
    START_TIME=$(date +%s)
}

cli_performance_end() {
    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - START_TIME))
    
    if [ $duration -lt 60 ]; then
        echo "⏱️ Completed in ${duration}s"
    else
        local minutes=$((duration / 60))
        local seconds=$((duration % 60))
        echo "⏱️ Completed in ${minutes}m ${seconds}s"
    fi
}

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

cli_detect_primary_branch() {
    # Function to detect primary branch (main vs master)
    local remote_branches
    remote_branches=$(git branch -r 2>/dev/null | grep -E "(origin/main|origin/master)")
    
    if echo "$remote_branches" | grep -q "origin/main"; then
        echo "main"
    elif echo "$remote_branches" | grep -q "origin/master"; then
        echo "master"  
    else
        # Fallback: check local branches
        if git branch 2>/dev/null | grep -q "main"; then
            echo "main"
        else
            echo "master"  # Default classical
        fi
    fi
}

cli_get_current_branch() {
    git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null
}

cli_get_commit_count_ahead() {
    local source_branch="$1"
    local target_branch="$2"
    
    git rev-list --count "$source_branch" ^"$target_branch" 2>/dev/null || echo "0"
}

cli_get_file_change_count() {
    local source_branch="$1" 
    local target_branch="$2"
    
    git diff --name-only "$target_branch..$source_branch" 2>/dev/null | wc -l
}

# =============================================================================
# INITIALIZATION
# =============================================================================

# Ensure performance tracking is initialized
if [ -z "$START_TIME" ]; then
    cli_performance_start
fi

# Export all functions for use in other scripts
export -f cli_header cli_section_header cli_separator cli_separator_thick
export -f cli_success_header cli_error_header
export -f cli_status_line cli_bullet_point
export -f cli_progress_start cli_progress_success cli_progress_error cli_progress_warning cli_progress_info cli_progress_step
export -f cli_highlight cli_dim cli_bold cli_emphasis
export -f cli_error_box cli_warning_box cli_info_box cli_success_box cli_critical_warning_box cli_education_box
export -f cli_confirm_critical cli_confirm_default_yes cli_confirm_default_no
export -f cli_gitflow_workflow_display cli_git_impact_preview
export -f cli_validate_git_working_directory cli_validate_branch_exists cli_validate_merge_conflicts
export -f clickup_update_task clickup_add_comment clickup_get_task_id_from_session
export -f cli_performance_start cli_performance_end
# Helper function for emergency version detection
detect_emergency_version() {
    if [ -f "package.json" ] && grep -q "version" package.json; then
        current_version=$(grep '"version"' package.json | sed 's/.*"version": *"\\([^"]*\\)".*/\\1/' | head -1)
        # Increment patch version for emergency
        echo "$current_version" | awk -F. '{printf "%d.%d.%d", $1, $2, $3+1}'
    elif [ -f "version.txt" ]; then
        cat version.txt | head -1
    elif [ -f "VERSION" ]; then
        cat VERSION | head -1
    else
        # Default emergency version
        echo "0.0.1"
    fi
}

export -f cli_detect_primary_branch cli_get_current_branch cli_get_commit_count_ahead cli_get_file_change_count cli_get_emergency_version detect_emergency_version
