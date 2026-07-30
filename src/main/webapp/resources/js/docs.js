(function () {
	'use strict';

	function escapeHtml(value) {
		return value.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
	}

	function inline(value) {
		var escaped = escapeHtml(value);
		escaped = escaped.replace(/`([^`]+)`/g, '<code>$1</code>');
		escaped = escaped.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
		return escaped.replace(/\[([^\]]+)\]\(([^)]+)\)/g, function (_, label, url) {
			var href = url;
			if (/^[a-zA-Z0-9-]+\.md$/.test(url)) {
				href = window.DOCS_CONTEXT_PATH + '/docs/' + documentKeyFromFilename(url);
			}
			if (!/^(https?:\/\/|\/)/.test(href)) { return label; }
			return '<a href="' + escapeHtml(href) + '">' + label + '</a>';
		});
	}

	function documentKeyFromFilename(filename) {
		var keys = {
			'README.md': 'overview', '01-architecture.md': 'architecture', '02-public-content.md': 'public-content',
			'03-member.md': 'member', '04-symposium-application.md': 'symposium-application',
			'05-board-comment.md': 'board-comment', '06-file-image.md': 'file-image', '07-admin.md': 'admin',
			'08-route-catalog.md': 'route-catalog', '09-chatbot.md': 'chatbot'
		};
		return keys[filename] || 'overview';
	}

	function renderTable(lines) {
		var rows = lines.filter(function (line, index) { return index !== 1; }).map(function (line) {
			return line.replace(/^\||\|$/g, '').split('|').map(function (cell) { return cell.trim(); });
		});
		var html = '<table><thead><tr>';
		rows[0].forEach(function (cell) { html += '<th>' + inline(cell) + '</th>'; });
		html += '</tr></thead><tbody>';
		rows.slice(1).forEach(function (row) { html += '<tr>' + row.map(function (cell) { return '<td>' + inline(cell) + '</td>'; }).join('') + '</tr>'; });
		return html + '</tbody></table>';
	}

	function renderMarkdown(markdown) {
		var lines = markdown.replace(/\r\n/g, '\n').split('\n'), html = '', index = 0;
		while (index < lines.length) {
			var line = lines[index];
			if (line.indexOf('```') === 0) {
				var language = line.substring(3).trim(), code = []; index++;
				while (index < lines.length && lines[index].indexOf('```') !== 0) { code.push(lines[index++]); }
				if (language === 'mermaid') { html += '<pre class="mermaid">' + escapeHtml(code.join('\n')) + '</pre>'; }
				else { html += '<pre><code>' + escapeHtml(code.join('\n')) + '</code></pre>'; }
				index++; continue;
			}
			if (/^\|.*\|\s*$/.test(line) && index + 1 < lines.length && /^\|?\s*:?-+/.test(lines[index + 1])) {
				var table = [line]; index++;
				while (index < lines.length && /^\|.*\|\s*$/.test(lines[index])) { table.push(lines[index++]); }
				html += renderTable(table); continue;
			}
			var heading = line.match(/^(#{1,3})\s+(.+)$/);
			if (heading) { var level = heading[1].length; html += '<h' + level + '>' + inline(heading[2]) + '</h' + level + '>'; index++; continue; }
			if (/^[-*]\s+/.test(line)) { var items = []; while (index < lines.length && /^[-*]\s+/.test(lines[index])) { items.push('<li>' + inline(lines[index].replace(/^[-*]\s+/, '')) + '</li>'); index++; } html += '<ul>' + items.join('') + '</ul>'; continue; }
			if (/^\d+\.\s+/.test(line)) { var ordered = []; while (index < lines.length && /^\d+\.\s+/.test(lines[index])) { ordered.push('<li>' + inline(lines[index].replace(/^\d+\.\s+/, '')) + '</li>'); index++; } html += '<ol>' + ordered.join('') + '</ol>'; continue; }
			if (line.trim() !== '') { html += '<p>' + inline(line) + '</p>'; }
			index++;
		}
		return html;
	}

	var shell = document.querySelector('.docs-shell');
	if (!shell) { return; }
	var documentKey = shell.getAttribute('data-document');
	window.DOCS_CONTEXT_PATH = shell.getAttribute('data-context') || '';
	fetch(window.DOCS_CONTEXT_PATH + '/docs/content/' + encodeURIComponent(documentKey), { credentials: 'same-origin' })
		.then(function (response) { if (!response.ok) { throw new Error('문서를 찾을 수 없습니다.'); } return response.text(); })
		.then(function (markdown) {
			document.querySelector('.docs-content').innerHTML = renderMarkdown(markdown);
			if (window.mermaid) { window.mermaid.initialize({ startOnLoad: false, securityLevel: 'strict', theme: 'base' }); window.mermaid.run({ querySelector: '.mermaid' }); }
		})
		.catch(function (error) { document.querySelector('.docs-content').innerHTML = '<p class="docs-error">' + escapeHtml(error.message) + '</p>'; });
}());
